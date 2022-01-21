//
// Copyright 2010-2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSSTSResources.h"
#import "AWSCocoaLumberjack.h"

@interface AWSSTSResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSSTSResources

+ (instancetype)sharedInstance {
    static AWSSTSResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSSTSResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSDDLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2011-06-15\",\
    \"endpointPrefix\":\"sts\",\
    \"globalEndpoint\":\"sts.amazonaws.com\",\
    \"protocol\":\"query\",\
    \"serviceAbbreviation\":\"AWS STS\",\
    \"serviceFullName\":\"AWS Security Token Service\",\
    \"serviceId\":\"STS\",\
    \"signatureVersion\":\"v4\",\
    \"uid\":\"sts-2011-06-15\",\
    \"xmlNamespace\":\"https://sts.amazonaws.com/doc/2011-06-15/\"\
  },\
  \"operations\":{\
    \"AssumeRole\":{\
      \"name\":\"AssumeRole\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"AssumeRoleRequest\"},\
      \"output\":{\
        \"shape\":\"AssumeRoleResponse\",\
        \"resultWrapper\":\"AssumeRoleResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"PackedPolicyTooLargeException\"},\
        {\"shape\":\"RegionDisabledException\"},\
        {\"shape\":\"ExpiredTokenException\"}\
      ],\
      \"documentation\":\"<p>Returns a set of temporary security credentials that you can use to access Amazon Web Services resources that you might not normally have access to. These temporary credentials consist of an access key ID, a secret access key, and a security token. Typically, you use <code>AssumeRole</code> within your account or for cross-account access. For a comparison of <code>AssumeRole</code> with other API operations that produce temporary credentials, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html\\\">Requesting Temporary Security Credentials</a> and <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison\\\">Comparing the Amazon Web Services STS API operations</a> in the <i>IAM User Guide</i>.</p> <p> <b>Permissions</b> </p> <p>The temporary security credentials created by <code>AssumeRole</code> can be used to make API calls to any Amazon Web Services service with the following exception: You cannot call the Amazon Web Services STS <code>GetFederationToken</code> or <code>GetSessionToken</code> API operations.</p> <p>(Optional) You can pass inline or managed <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">session policies</a> to this operation. You can pass a single JSON policy document to use as an inline session policy. You can also specify up to 10 managed policies to use as managed session policies. The plaintext that you use for both inline and managed session policies can't exceed 2,048 characters. Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent Amazon Web Services API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>.</p> <p>When you create a role, you create two policies: A role trust policy that specifies <i>who</i> can assume the role and a permissions policy that specifies <i>what</i> can be done with the role. You specify the trusted principal who is allowed to assume the role in the role trust policy.</p> <p>To assume a role from a different account, your Amazon Web Services account must be trusted by the role. The trust relationship is defined in the role's trust policy when the role is created. That trust policy states which accounts are allowed to delegate that access to users in the account. </p> <p>A user who wants to access a role in a different account must also have permissions that are delegated from the user account administrator. The administrator must attach a policy that allows the user to call <code>AssumeRole</code> for the ARN of the role in the other account.</p> <p>To allow a user to assume a role in the same account, you can do either of the following:</p> <ul> <li> <p>Attach a policy to the user that allows the user to call <code>AssumeRole</code> (as long as the role's trust policy trusts the account).</p> </li> <li> <p>Add the user as a principal directly in the role's trust policy.</p> </li> </ul> <p>You can do either because the roleâs trust policy acts as an IAM resource-based policy. When a resource-based policy grants access to a principal in the same account, no additional identity-based policy is required. For more information about trust policies and resource-based policies, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html\\\">IAM Policies</a> in the <i>IAM User Guide</i>.</p> <p> <b>Tags</b> </p> <p>(Optional) You can pass tag key-value pairs to your session. These tags are called session tags. For more information about session tags, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\\\">Passing Session Tags in STS</a> in the <i>IAM User Guide</i>.</p> <p>An administrator must grant you the permissions necessary to pass session tags. The administrator can also create granular permissions to allow you to pass only specific session tags. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_attribute-based-access-control.html\\\">Tutorial: Using Tags for Attribute-Based Access Control</a> in the <i>IAM User Guide</i>.</p> <p>You can set the session tags as transitive. Transitive tags persist during role chaining. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html#id_session-tags_role-chaining\\\">Chaining Roles with Session Tags</a> in the <i>IAM User Guide</i>.</p> <p> <b>Using MFA with AssumeRole</b> </p> <p>(Optional) You can include multi-factor authentication (MFA) information when you call <code>AssumeRole</code>. This is useful for cross-account scenarios to ensure that the user that assumes the role has been authenticated with an Amazon Web Services MFA device. In that scenario, the trust policy of the role being assumed includes a condition that tests for MFA authentication. If the caller does not include valid MFA information, the request to assume the role is denied. The condition in a trust policy that tests for MFA authentication might look like the following example.</p> <p> <code>\\\"Condition\\\": {\\\"Bool\\\": {\\\"aws:MultiFactorAuthPresent\\\": true}}</code> </p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/MFAProtectedAPI.html\\\">Configuring MFA-Protected API Access</a> in the <i>IAM User Guide</i> guide.</p> <p>To use MFA with <code>AssumeRole</code>, you pass values for the <code>SerialNumber</code> and <code>TokenCode</code> parameters. The <code>SerialNumber</code> value identifies the user's hardware or virtual MFA device. The <code>TokenCode</code> is the time-based one-time password (TOTP) that the MFA device produces. </p>\"\
    },\
    \"AssumeRoleWithSAML\":{\
      \"name\":\"AssumeRoleWithSAML\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"AssumeRoleWithSAMLRequest\"},\
      \"output\":{\
        \"shape\":\"AssumeRoleWithSAMLResponse\",\
        \"resultWrapper\":\"AssumeRoleWithSAMLResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"PackedPolicyTooLargeException\"},\
        {\"shape\":\"IDPRejectedClaimException\"},\
        {\"shape\":\"InvalidIdentityTokenException\"},\
        {\"shape\":\"ExpiredTokenException\"},\
        {\"shape\":\"RegionDisabledException\"}\
      ],\
      \"documentation\":\"<p>Returns a set of temporary security credentials for users who have been authenticated via a SAML authentication response. This operation provides a mechanism for tying an enterprise identity store or directory to role-based Amazon Web Services access without user-specific credentials or configuration. For a comparison of <code>AssumeRoleWithSAML</code> with the other API operations that produce temporary credentials, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html\\\">Requesting Temporary Security Credentials</a> and <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison\\\">Comparing the Amazon Web Services STS API operations</a> in the <i>IAM User Guide</i>.</p> <p>The temporary security credentials returned by this operation consist of an access key ID, a secret access key, and a security token. Applications can use these temporary security credentials to sign calls to Amazon Web Services services.</p> <p> <b>Session Duration</b> </p> <p>By default, the temporary security credentials created by <code>AssumeRoleWithSAML</code> last for one hour. However, you can use the optional <code>DurationSeconds</code> parameter to specify the duration of your session. Your role session lasts for the duration that you specify, or until the time specified in the SAML authentication response's <code>SessionNotOnOrAfter</code> value, whichever is shorter. You can provide a <code>DurationSeconds</code> value from 900 seconds (15 minutes) up to the maximum session duration setting for the role. This setting can have a value from 1 hour to 12 hours. To learn how to view the maximum value for your role, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html#id_roles_use_view-role-max-session\\\">View the Maximum Session Duration Setting for a Role</a> in the <i>IAM User Guide</i>. The maximum session duration limit applies when you use the <code>AssumeRole*</code> API operations or the <code>assume-role*</code> CLI commands. However the limit does not apply when you use those operations to create a console URL. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html\\\">Using IAM Roles</a> in the <i>IAM User Guide</i>.</p> <note> <p> <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html#iam-term-role-chaining\\\">Role chaining</a> limits your CLI or Amazon Web Services API role session to a maximum of one hour. When you use the <code>AssumeRole</code> API operation to assume a role, you can specify the duration of your role session with the <code>DurationSeconds</code> parameter. You can specify a parameter value of up to 43200 seconds (12 hours), depending on the maximum session duration setting for your role. However, if you assume a role using role chaining and provide a <code>DurationSeconds</code> parameter value greater than one hour, the operation fails.</p> </note> <p> <b>Permissions</b> </p> <p>The temporary security credentials created by <code>AssumeRoleWithSAML</code> can be used to make API calls to any Amazon Web Services service with the following exception: you cannot call the STS <code>GetFederationToken</code> or <code>GetSessionToken</code> API operations.</p> <p>(Optional) You can pass inline or managed <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">session policies</a> to this operation. You can pass a single JSON policy document to use as an inline session policy. You can also specify up to 10 managed policies to use as managed session policies. The plaintext that you use for both inline and managed session policies can't exceed 2,048 characters. Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent Amazon Web Services API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>.</p> <p>Calling <code>AssumeRoleWithSAML</code> does not require the use of Amazon Web Services security credentials. The identity of the caller is validated by using keys in the metadata document that is uploaded for the SAML provider entity for your identity provider. </p> <important> <p>Calling <code>AssumeRoleWithSAML</code> can result in an entry in your CloudTrail logs. The entry includes the value in the <code>NameID</code> element of the SAML assertion. We recommend that you use a <code>NameIDType</code> that is not associated with any personally identifiable information (PII). For example, you could instead use the persistent identifier (<code>urn:oasis:names:tc:SAML:2.0:nameid-format:persistent</code>).</p> </important> <p> <b>Tags</b> </p> <p>(Optional) You can configure your IdP to pass attributes into your SAML assertion as session tags. Each session tag consists of a key name and an associated value. For more information about session tags, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\\\">Passing Session Tags in STS</a> in the <i>IAM User Guide</i>.</p> <p>You can pass up to 50 session tags. The plaintext session tag keys canât exceed 128 characters and the values canât exceed 256 characters. For these and additional limits, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html#reference_iam-limits-entity-length\\\">IAM and STS Character Limits</a> in the <i>IAM User Guide</i>.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note> <p>You can pass a session tag with the same key as a tag that is attached to the role. When you do, session tags override the role's tags with the same key.</p> <p>An administrator must grant you the permissions necessary to pass session tags. The administrator can also create granular permissions to allow you to pass only specific session tags. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_attribute-based-access-control.html\\\">Tutorial: Using Tags for Attribute-Based Access Control</a> in the <i>IAM User Guide</i>.</p> <p>You can set the session tags as transitive. Transitive tags persist during role chaining. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html#id_session-tags_role-chaining\\\">Chaining Roles with Session Tags</a> in the <i>IAM User Guide</i>.</p> <p> <b>SAML Configuration</b> </p> <p>Before your application can call <code>AssumeRoleWithSAML</code>, you must configure your SAML identity provider (IdP) to issue the claims required by Amazon Web Services. Additionally, you must use Identity and Access Management (IAM) to create a SAML provider entity in your Amazon Web Services account that represents your identity provider. You must also create an IAM role that specifies this SAML provider in its trust policy. </p> <p>For more information, see the following resources:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_saml.html\\\">About SAML 2.0-based Federation</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml.html\\\">Creating SAML Identity Providers</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml_relying-party.html\\\">Configuring a Relying Party and Claims</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_saml.html\\\">Creating a Role for SAML 2.0 Federation</a> in the <i>IAM User Guide</i>. </p> </li> </ul>\"\
    },\
    \"AssumeRoleWithWebIdentity\":{\
      \"name\":\"AssumeRoleWithWebIdentity\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"AssumeRoleWithWebIdentityRequest\"},\
      \"output\":{\
        \"shape\":\"AssumeRoleWithWebIdentityResponse\",\
        \"resultWrapper\":\"AssumeRoleWithWebIdentityResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"PackedPolicyTooLargeException\"},\
        {\"shape\":\"IDPRejectedClaimException\"},\
        {\"shape\":\"IDPCommunicationErrorException\"},\
        {\"shape\":\"InvalidIdentityTokenException\"},\
        {\"shape\":\"ExpiredTokenException\"},\
        {\"shape\":\"RegionDisabledException\"}\
      ],\
      \"documentation\":\"<p>Returns a set of temporary security credentials for users who have been authenticated in a mobile or web application with a web identity provider. Example providers include Amazon Cognito, Login with Amazon, Facebook, Google, or any OpenID Connect-compatible identity provider.</p> <note> <p>For mobile applications, we recommend that you use Amazon Cognito. You can use Amazon Cognito with the <a href=\\\"http://aws.amazon.com/sdkforios/\\\">Amazon Web Services SDK for iOS Developer Guide</a> and the <a href=\\\"http://aws.amazon.com/sdkforandroid/\\\">Amazon Web Services SDK for Android Developer Guide</a> to uniquely identify a user. You can also supply the user with a consistent identity throughout the lifetime of an application.</p> <p>To learn more about Amazon Cognito, see <a href=\\\"https://docs.aws.amazon.com/mobile/sdkforandroid/developerguide/cognito-auth.html#d0e840\\\">Amazon Cognito Overview</a> in <i>Amazon Web Services SDK for Android Developer Guide</i> and <a href=\\\"https://docs.aws.amazon.com/mobile/sdkforios/developerguide/cognito-auth.html#d0e664\\\">Amazon Cognito Overview</a> in the <i>Amazon Web Services SDK for iOS Developer Guide</i>.</p> </note> <p>Calling <code>AssumeRoleWithWebIdentity</code> does not require the use of Amazon Web Services security credentials. Therefore, you can distribute an application (for example, on mobile devices) that requests temporary security credentials without including long-term Amazon Web Services credentials in the application. You also don't need to deploy server-based proxy services that use long-term Amazon Web Services credentials. Instead, the identity of the caller is validated by using a token from the web identity provider. For a comparison of <code>AssumeRoleWithWebIdentity</code> with the other API operations that produce temporary credentials, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html\\\">Requesting Temporary Security Credentials</a> and <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison\\\">Comparing the Amazon Web Services STS API operations</a> in the <i>IAM User Guide</i>.</p> <p>The temporary security credentials returned by this API consist of an access key ID, a secret access key, and a security token. Applications can use these temporary security credentials to sign calls to Amazon Web Services service API operations.</p> <p> <b>Session Duration</b> </p> <p>By default, the temporary security credentials created by <code>AssumeRoleWithWebIdentity</code> last for one hour. However, you can use the optional <code>DurationSeconds</code> parameter to specify the duration of your session. You can provide a value from 900 seconds (15 minutes) up to the maximum session duration setting for the role. This setting can have a value from 1 hour to 12 hours. To learn how to view the maximum value for your role, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html#id_roles_use_view-role-max-session\\\">View the Maximum Session Duration Setting for a Role</a> in the <i>IAM User Guide</i>. The maximum session duration limit applies when you use the <code>AssumeRole*</code> API operations or the <code>assume-role*</code> CLI commands. However the limit does not apply when you use those operations to create a console URL. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html\\\">Using IAM Roles</a> in the <i>IAM User Guide</i>. </p> <p> <b>Permissions</b> </p> <p>The temporary security credentials created by <code>AssumeRoleWithWebIdentity</code> can be used to make API calls to any Amazon Web Services service with the following exception: you cannot call the STS <code>GetFederationToken</code> or <code>GetSessionToken</code> API operations.</p> <p>(Optional) You can pass inline or managed <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">session policies</a> to this operation. You can pass a single JSON policy document to use as an inline session policy. You can also specify up to 10 managed policies to use as managed session policies. The plaintext that you use for both inline and managed session policies can't exceed 2,048 characters. Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent Amazon Web Services API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>.</p> <p> <b>Tags</b> </p> <p>(Optional) You can configure your IdP to pass attributes into your web identity token as session tags. Each session tag consists of a key name and an associated value. For more information about session tags, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\\\">Passing Session Tags in STS</a> in the <i>IAM User Guide</i>.</p> <p>You can pass up to 50 session tags. The plaintext session tag keys canât exceed 128 characters and the values canât exceed 256 characters. For these and additional limits, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html#reference_iam-limits-entity-length\\\">IAM and STS Character Limits</a> in the <i>IAM User Guide</i>.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note> <p>You can pass a session tag with the same key as a tag that is attached to the role. When you do, the session tag overrides the role tag with the same key.</p> <p>An administrator must grant you the permissions necessary to pass session tags. The administrator can also create granular permissions to allow you to pass only specific session tags. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_attribute-based-access-control.html\\\">Tutorial: Using Tags for Attribute-Based Access Control</a> in the <i>IAM User Guide</i>.</p> <p>You can set the session tags as transitive. Transitive tags persist during role chaining. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html#id_session-tags_role-chaining\\\">Chaining Roles with Session Tags</a> in the <i>IAM User Guide</i>.</p> <p> <b>Identities</b> </p> <p>Before your application can call <code>AssumeRoleWithWebIdentity</code>, you must have an identity token from a supported identity provider and create a role that the application can assume. The role that your application assumes must trust the identity provider that is associated with the identity token. In other words, the identity provider must be specified in the role's trust policy. </p> <important> <p>Calling <code>AssumeRoleWithWebIdentity</code> can result in an entry in your CloudTrail logs. The entry includes the <a href=\\\"http://openid.net/specs/openid-connect-core-1_0.html#Claims\\\">Subject</a> of the provided web identity token. We recommend that you avoid using any personally identifiable information (PII) in this field. For example, you could instead use a GUID or a pairwise identifier, as <a href=\\\"http://openid.net/specs/openid-connect-core-1_0.html#SubjectIDTypes\\\">suggested in the OIDC specification</a>.</p> </important> <p>For more information about how to use web identity federation and the <code>AssumeRoleWithWebIdentity</code> API, see the following resources: </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_oidc_manual.html\\\">Using Web Identity Federation API Operations for Mobile Apps</a> and <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_assumerolewithwebidentity\\\">Federation Through a Web-based Identity Provider</a>. </p> </li> <li> <p> <a href=\\\"https://aws.amazon.com/blogs/aws/the-aws-web-identity-federation-playground/\\\"> Web Identity Federation Playground</a>. Walk through the process of authenticating through Login with Amazon, Facebook, or Google, getting temporary security credentials, and then using those credentials to make a request to Amazon Web Services. </p> </li> <li> <p> <a href=\\\"http://aws.amazon.com/sdkforios/\\\">Amazon Web Services SDK for iOS Developer Guide</a> and <a href=\\\"http://aws.amazon.com/sdkforandroid/\\\">Amazon Web Services SDK for Android Developer Guide</a>. These toolkits contain sample apps that show how to invoke the identity providers. The toolkits then show how to use the information from these providers to get and use temporary security credentials. </p> </li> <li> <p> <a href=\\\"http://aws.amazon.com/articles/web-identity-federation-with-mobile-applications\\\">Web Identity Federation with Mobile Applications</a>. This article discusses web identity federation and shows an example of how to use web identity federation to get access to content in Amazon S3. </p> </li> </ul>\"\
    },\
    \"DecodeAuthorizationMessage\":{\
      \"name\":\"DecodeAuthorizationMessage\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DecodeAuthorizationMessageRequest\"},\
      \"output\":{\
        \"shape\":\"DecodeAuthorizationMessageResponse\",\
        \"resultWrapper\":\"DecodeAuthorizationMessageResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"InvalidAuthorizationMessageException\"}\
      ],\
      \"documentation\":\"<p>Decodes additional information about the authorization status of a request from an encoded message returned in response to an Amazon Web Services request.</p> <p>For example, if a user is not authorized to perform an operation that he or she has requested, the request returns a <code>Client.UnauthorizedOperation</code> response (an HTTP 403 response). Some Amazon Web Services operations additionally return an encoded message that can provide details about this authorization failure. </p> <note> <p>Only certain Amazon Web Services operations return an encoded authorization message. The documentation for an individual operation indicates whether that operation returns an encoded message in addition to returning an HTTP code.</p> </note> <p>The message is encoded because the details of the authorization status can contain privileged information that the user who requested the operation should not see. To decode an authorization status message, a user must be granted permissions through an IAM <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html\\\">policy</a> to request the <code>DecodeAuthorizationMessage</code> (<code>sts:DecodeAuthorizationMessage</code>) action. </p> <p>The decoded message includes the following type of information:</p> <ul> <li> <p>Whether the request was denied due to an explicit deny or due to the absence of an explicit allow. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html#policy-eval-denyallow\\\">Determining Whether a Request is Allowed or Denied</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p>The principal who made the request.</p> </li> <li> <p>The requested action.</p> </li> <li> <p>The requested resource.</p> </li> <li> <p>The values of condition keys in the context of the user's request.</p> </li> </ul>\"\
    },\
    \"GetAccessKeyInfo\":{\
      \"name\":\"GetAccessKeyInfo\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetAccessKeyInfoRequest\"},\
      \"output\":{\
        \"shape\":\"GetAccessKeyInfoResponse\",\
        \"resultWrapper\":\"GetAccessKeyInfoResult\"\
      },\
      \"documentation\":\"<p>Returns the account identifier for the specified access key ID.</p> <p>Access keys consist of two parts: an access key ID (for example, <code>AKIAIOSFODNN7EXAMPLE</code>) and a secret access key (for example, <code>wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY</code>). For more information about access keys, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html\\\">Managing Access Keys for IAM Users</a> in the <i>IAM User Guide</i>.</p> <p>When you pass an access key ID to this operation, it returns the ID of the Amazon Web Services account to which the keys belong. Access key IDs beginning with <code>AKIA</code> are long-term credentials for an IAM user or the Amazon Web Services account root user. Access key IDs beginning with <code>ASIA</code> are temporary credentials that are created using STS operations. If the account in the response belongs to you, you can sign in as the root user and review your root user access keys. Then, you can pull a <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_getting-report.html\\\">credentials report</a> to learn which IAM user owns the keys. To learn who requested the temporary credentials for an <code>ASIA</code> access key, view the STS events in your <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/cloudtrail-integration.html\\\">CloudTrail logs</a> in the <i>IAM User Guide</i>.</p> <p>This operation does not indicate the state of the access key. The key might be active, inactive, or deleted. Active keys might not have permissions to perform an operation. Providing a deleted access key might return an error that the key doesn't exist.</p>\"\
    },\
    \"GetCallerIdentity\":{\
      \"name\":\"GetCallerIdentity\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetCallerIdentityRequest\"},\
      \"output\":{\
        \"shape\":\"GetCallerIdentityResponse\",\
        \"resultWrapper\":\"GetCallerIdentityResult\"\
      },\
      \"documentation\":\"<p>Returns details about the IAM user or role whose credentials are used to call the operation.</p> <note> <p>No permissions are required to perform this operation. If an administrator adds a policy to your IAM user or role that explicitly denies access to the <code>sts:GetCallerIdentity</code> action, you can still perform this operation. Permissions are not required because the same information is returned when an IAM user or role is denied access. To view an example response, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot_general.html#troubleshoot_general_access-denied-delete-mfa\\\">I Am Not Authorized to Perform: iam:DeleteVirtualMFADevice</a> in the <i>IAM User Guide</i>.</p> </note>\"\
    },\
    \"GetFederationToken\":{\
      \"name\":\"GetFederationToken\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetFederationTokenRequest\"},\
      \"output\":{\
        \"shape\":\"GetFederationTokenResponse\",\
        \"resultWrapper\":\"GetFederationTokenResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"PackedPolicyTooLargeException\"},\
        {\"shape\":\"RegionDisabledException\"}\
      ],\
      \"documentation\":\"<p>Returns a set of temporary security credentials (consisting of an access key ID, a secret access key, and a security token) for a federated user. A typical use is in a proxy application that gets temporary security credentials on behalf of distributed applications inside a corporate network. You must call the <code>GetFederationToken</code> operation using the long-term security credentials of an IAM user. As a result, this call is appropriate in contexts where those credentials can be safely stored, usually in a server-based application. For a comparison of <code>GetFederationToken</code> with the other API operations that produce temporary credentials, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html\\\">Requesting Temporary Security Credentials</a> and <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison\\\">Comparing the Amazon Web Services STS API operations</a> in the <i>IAM User Guide</i>.</p> <note> <p>You can create a mobile-based or browser-based app that can authenticate users using a web identity provider like Login with Amazon, Facebook, Google, or an OpenID Connect-compatible identity provider. In this case, we recommend that you use <a href=\\\"http://aws.amazon.com/cognito/\\\">Amazon Cognito</a> or <code>AssumeRoleWithWebIdentity</code>. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_assumerolewithwebidentity\\\">Federation Through a Web-based Identity Provider</a> in the <i>IAM User Guide</i>.</p> </note> <p>You can also call <code>GetFederationToken</code> using the security credentials of an Amazon Web Services account root user, but we do not recommend it. Instead, we recommend that you create an IAM user for the purpose of the proxy application. Then attach a policy to the IAM user that limits federated users to only the actions and resources that they need to access. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html\\\">IAM Best Practices</a> in the <i>IAM User Guide</i>. </p> <p> <b>Session duration</b> </p> <p>The temporary credentials are valid for the specified duration, from 900 seconds (15 minutes) up to a maximum of 129,600 seconds (36 hours). The default session duration is 43,200 seconds (12 hours). Temporary credentials obtained by using the Amazon Web Services account root user credentials have a maximum duration of 3,600 seconds (1 hour).</p> <p> <b>Permissions</b> </p> <p>You can use the temporary credentials created by <code>GetFederationToken</code> in any Amazon Web Services service except the following:</p> <ul> <li> <p>You cannot call any IAM operations using the CLI or the Amazon Web Services API. </p> </li> <li> <p>You cannot call any STS operations except <code>GetCallerIdentity</code>.</p> </li> </ul> <p>You must pass an inline or managed <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">session policy</a> to this operation. You can pass a single JSON policy document to use as an inline session policy. You can also specify up to 10 managed policies to use as managed session policies. The plaintext that you use for both inline and managed session policies can't exceed 2,048 characters.</p> <p>Though the session policy parameters are optional, if you do not pass a policy, then the resulting federated user session has no permissions. When you pass session policies, the session permissions are the intersection of the IAM user policies and the session policies that you pass. This gives you a way to further restrict the permissions for a federated user. You cannot use session policies to grant more permissions than those that are defined in the permissions policy of the IAM user. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>. For information about using <code>GetFederationToken</code> to create temporary security credentials, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_getfederationtoken\\\">GetFederationTokenâFederation Through a Custom Identity Broker</a>. </p> <p>You can use the credentials to access a resource that has a resource-based policy. If that policy specifically references the federated user session in the <code>Principal</code> element of the policy, the session has the permissions allowed by the policy. These permissions are granted in addition to the permissions granted by the session policies.</p> <p> <b>Tags</b> </p> <p>(Optional) You can pass tag key-value pairs to your session. These are called session tags. For more information about session tags, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\\\">Passing Session Tags in STS</a> in the <i>IAM User Guide</i>.</p> <note> <p>You can create a mobile-based or browser-based app that can authenticate users using a web identity provider like Login with Amazon, Facebook, Google, or an OpenID Connect-compatible identity provider. In this case, we recommend that you use <a href=\\\"http://aws.amazon.com/cognito/\\\">Amazon Cognito</a> or <code>AssumeRoleWithWebIdentity</code>. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_assumerolewithwebidentity\\\">Federation Through a Web-based Identity Provider</a> in the <i>IAM User Guide</i>.</p> </note> <p>An administrator must grant you the permissions necessary to pass session tags. The administrator can also create granular permissions to allow you to pass only specific session tags. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_attribute-based-access-control.html\\\">Tutorial: Using Tags for Attribute-Based Access Control</a> in the <i>IAM User Guide</i>.</p> <p>Tag keyâvalue pairs are not case sensitive, but case is preserved. This means that you cannot have separate <code>Department</code> and <code>department</code> tag keys. Assume that the user that you are federating has the <code>Department</code>=<code>Marketing</code> tag and you pass the <code>department</code>=<code>engineering</code> session tag. <code>Department</code> and <code>department</code> are not saved as separate tags, and the session tag passed in the request takes precedence over the user tag.</p>\"\
    },\
    \"GetSessionToken\":{\
      \"name\":\"GetSessionToken\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetSessionTokenRequest\"},\
      \"output\":{\
        \"shape\":\"GetSessionTokenResponse\",\
        \"resultWrapper\":\"GetSessionTokenResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"RegionDisabledException\"}\
      ],\
      \"documentation\":\"<p>Returns a set of temporary credentials for an Amazon Web Services account or IAM user. The credentials consist of an access key ID, a secret access key, and a security token. Typically, you use <code>GetSessionToken</code> if you want to use MFA to protect programmatic calls to specific Amazon Web Services API operations like Amazon EC2 <code>StopInstances</code>. MFA-enabled IAM users would need to call <code>GetSessionToken</code> and submit an MFA code that is associated with their MFA device. Using the temporary security credentials that are returned from the call, IAM users can then make programmatic calls to API operations that require MFA authentication. If you do not supply a correct MFA code, then the API returns an access denied error. For a comparison of <code>GetSessionToken</code> with the other API operations that produce temporary credentials, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html\\\">Requesting Temporary Security Credentials</a> and <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison\\\">Comparing the Amazon Web Services STS API operations</a> in the <i>IAM User Guide</i>.</p> <p> <b>Session Duration</b> </p> <p>The <code>GetSessionToken</code> operation must be called by using the long-term Amazon Web Services security credentials of the Amazon Web Services account root user or an IAM user. Credentials that are created by IAM users are valid for the duration that you specify. This duration can range from 900 seconds (15 minutes) up to a maximum of 129,600 seconds (36 hours), with a default of 43,200 seconds (12 hours). Credentials based on account credentials can range from 900 seconds (15 minutes) up to 3,600 seconds (1 hour), with a default of 1 hour. </p> <p> <b>Permissions</b> </p> <p>The temporary security credentials created by <code>GetSessionToken</code> can be used to make API calls to any Amazon Web Services service with the following exceptions:</p> <ul> <li> <p>You cannot call any IAM API operations unless MFA authentication information is included in the request.</p> </li> <li> <p>You cannot call any STS API <i>except</i> <code>AssumeRole</code> or <code>GetCallerIdentity</code>.</p> </li> </ul> <note> <p>We recommend that you do not call <code>GetSessionToken</code> with Amazon Web Services account root user credentials. Instead, follow our <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#create-iam-users\\\">best practices</a> by creating one or more IAM users, giving them the necessary permissions, and using IAM users for everyday interaction with Amazon Web Services. </p> </note> <p>The credentials that are returned by <code>GetSessionToken</code> are based on permissions associated with the user whose credentials were used to call the operation. If <code>GetSessionToken</code> is called using Amazon Web Services account root user credentials, the temporary credentials have root user permissions. Similarly, if <code>GetSessionToken</code> is called using the credentials of an IAM user, the temporary credentials have the same permissions as the IAM user. </p> <p>For more information about using <code>GetSessionToken</code> to create temporary credentials, go to <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_getsessiontoken\\\">Temporary Credentials for Users in Untrusted Environments</a> in the <i>IAM User Guide</i>. </p>\"\
    }\
  },\
  \"shapes\":{\
    \"AssumeRoleRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleArn\",\
        \"RoleSessionName\"\
      ],\
      \"members\":{\
        \"RoleArn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the role to assume.</p>\"\
        },\
        \"RoleSessionName\":{\
          \"shape\":\"roleSessionNameType\",\
          \"documentation\":\"<p>An identifier for the assumed role session.</p> <p>Use the role session name to uniquely identify a session when the same role is assumed by different principals or for different reasons. In cross-account scenarios, the role session name is visible to, and can be logged by the account that owns the role. The role session name is also used in the ARN of the assumed role principal. This means that subsequent cross-account API requests that use the temporary security credentials will expose the role session name to the external account in their CloudTrail logs.</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        },\
        \"PolicyArns\":{\
          \"shape\":\"policyDescriptorListType\",\
          \"documentation\":\"<p>The Amazon Resource Names (ARNs) of the IAM managed policies that you want to use as managed session policies. The policies must exist in the same account as the role.</p> <p>This parameter is optional. You can provide up to 10 managed policy ARNs. However, the plaintext that you use for both inline and managed session policies can't exceed 2,048 characters. For more information about ARNs, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and Amazon Web Services Service Namespaces</a> in the Amazon Web Services General Reference.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note> <p>Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent Amazon Web Services API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>.</p>\"\
        },\
        \"Policy\":{\
          \"shape\":\"sessionPolicyDocumentType\",\
          \"documentation\":\"<p>An IAM policy in JSON format that you want to use as an inline session policy.</p> <p>This parameter is optional. Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent Amazon Web Services API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>.</p> <p>The plaintext that you use for both inline and managed session policies can't exceed 2,048 characters. The JSON policy characters can be any ASCII character from the space character to the end of the valid character list (\\\\u0020 through \\\\u00FF). It can also include the tab (\\\\u0009), linefeed (\\\\u000A), and carriage return (\\\\u000D) characters.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"roleDurationSecondsType\",\
          \"documentation\":\"<p>The duration, in seconds, of the role session. The value specified can range from 900 seconds (15 minutes) up to the maximum session duration set for the role. The maximum session duration setting can have a value from 1 hour to 12 hours. If you specify a value higher than this setting or the administrator setting (whichever is lower), the operation fails. For example, if you specify a session duration of 12 hours, but your administrator set the maximum session duration to 6 hours, your operation fails. </p> <p>Role chaining limits your Amazon Web Services CLI or Amazon Web Services API role session to a maximum of one hour. When you use the <code>AssumeRole</code> API operation to assume a role, you can specify the duration of your role session with the <code>DurationSeconds</code> parameter. You can specify a parameter value of up to 43200 seconds (12 hours), depending on the maximum session duration setting for your role. However, if you assume a role using role chaining and provide a <code>DurationSeconds</code> parameter value greater than one hour, the operation fails. To learn how to view the maximum value for your role, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html#id_roles_use_view-role-max-session\\\">View the Maximum Session Duration Setting for a Role</a> in the <i>IAM User Guide</i>.</p> <p>By default, the value is set to <code>3600</code> seconds. </p> <note> <p>The <code>DurationSeconds</code> parameter is separate from the duration of a console session that you might request using the returned credentials. The request to the federation endpoint for a console sign-in token takes a <code>SessionDuration</code> parameter that specifies the maximum length of the console session. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html\\\">Creating a URL that Enables Federated Users to Access the Amazon Web Services Management Console</a> in the <i>IAM User Guide</i>.</p> </note>\"\
        },\
        \"Tags\":{\
          \"shape\":\"tagListType\",\
          \"documentation\":\"<p>A list of session tags that you want to pass. Each session tag consists of a key name and an associated value. For more information about session tags, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\\\">Tagging Amazon Web Services STS Sessions</a> in the <i>IAM User Guide</i>.</p> <p>This parameter is optional. You can pass up to 50 session tags. The plaintext session tag keys canât exceed 128 characters, and the values canât exceed 256 characters. For these and additional limits, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html#reference_iam-limits-entity-length\\\">IAM and STS Character Limits</a> in the <i>IAM User Guide</i>.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note> <p>You can pass a session tag with the same key as a tag that is already attached to the role. When you do, session tags override a role tag with the same key. </p> <p>Tag keyâvalue pairs are not case sensitive, but case is preserved. This means that you cannot have separate <code>Department</code> and <code>department</code> tag keys. Assume that the role has the <code>Department</code>=<code>Marketing</code> tag and you pass the <code>department</code>=<code>engineering</code> session tag. <code>Department</code> and <code>department</code> are not saved as separate tags, and the session tag passed in the request takes precedence over the role tag.</p> <p>Additionally, if you used temporary credentials to perform this operation, the new session inherits any transitive session tags from the calling session. If you pass a session tag with the same key as an inherited tag, the operation fails. To view the inherited tags for a session, see the CloudTrail logs. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/session-tags.html#id_session-tags_ctlogs\\\">Viewing Session Tags in CloudTrail</a> in the <i>IAM User Guide</i>.</p>\"\
        },\
        \"TransitiveTagKeys\":{\
          \"shape\":\"tagKeyListType\",\
          \"documentation\":\"<p>A list of keys for session tags that you want to set as transitive. If you set a tag key as transitive, the corresponding key and value passes to subsequent sessions in a role chain. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html#id_session-tags_role-chaining\\\">Chaining Roles with Session Tags</a> in the <i>IAM User Guide</i>.</p> <p>This parameter is optional. When you set session tags as transitive, the session policy and session tags packed binary limit is not affected.</p> <p>If you choose not to specify a transitive tag key, then no tags are passed from this session to any subsequent sessions.</p>\"\
        },\
        \"ExternalId\":{\
          \"shape\":\"externalIdType\",\
          \"documentation\":\"<p>A unique identifier that might be required when you assume a role in another account. If the administrator of the account to which the role belongs provided you with an external ID, then provide that value in the <code>ExternalId</code> parameter. This value can be any string, such as a passphrase or account number. A cross-account role is usually set up to trust everyone in an account. Therefore, the administrator of the trusting account might send an external ID to the administrator of the trusted account. That way, only someone with the ID can assume the role, rather than everyone in the account. For more information about the external ID, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html\\\">How to Use an External ID When Granting Access to Your Amazon Web Services Resources to a Third Party</a> in the <i>IAM User Guide</i>.</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@:/-</p>\"\
        },\
        \"SerialNumber\":{\
          \"shape\":\"serialNumberType\",\
          \"documentation\":\"<p>The identification number of the MFA device that is associated with the user who is making the <code>AssumeRole</code> call. Specify this value if the trust policy of the role being assumed includes a condition that requires MFA authentication. The value is either the serial number for a hardware device (such as <code>GAHT12345678</code>) or an Amazon Resource Name (ARN) for a virtual device (such as <code>arn:aws:iam::123456789012:mfa/user</code>).</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        },\
        \"TokenCode\":{\
          \"shape\":\"tokenCodeType\",\
          \"documentation\":\"<p>The value provided by the MFA device, if the trust policy of the role being assumed requires MFA. (In other words, if the policy includes a condition that tests for MFA). If the role being assumed requires MFA and if the <code>TokenCode</code> value is missing or expired, the <code>AssumeRole</code> call returns an \\\"access denied\\\" error.</p> <p>The format for this parameter, as described by its regex pattern, is a sequence of six numeric digits.</p>\"\
        },\
        \"SourceIdentity\":{\
          \"shape\":\"sourceIdentityType\",\
          \"documentation\":\"<p>The source identity specified by the principal that is calling the <code>AssumeRole</code> operation.</p> <p>You can require users to specify a source identity when they assume a role. You do this by using the <code>sts:SourceIdentity</code> condition key in a role trust policy. You can use source identity information in CloudTrail logs to determine who took actions with a role. You can use the <code>aws:SourceIdentity</code> condition key to further control access to Amazon Web Services resources based on the value of source identity. For more information about using source identity, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_monitor.html\\\">Monitor and control actions taken with assumed roles</a> in the <i>IAM User Guide</i>.</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-. You cannot use a value that begins with the text <code>aws:</code>. This prefix is reserved for Amazon Web Services internal use.</p>\"\
        }\
      }\
    },\
    \"AssumeRoleResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Credentials\":{\
          \"shape\":\"Credentials\",\
          \"documentation\":\"<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <note> <p>The size of the security token that STS API operations return is not fixed. We strongly recommend that you make no assumptions about the maximum size.</p> </note>\"\
        },\
        \"AssumedRoleUser\":{\
          \"shape\":\"AssumedRoleUser\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) and the assumed role ID, which are identifiers that you can use to refer to the resulting temporary security credentials. For example, you can reference these credentials as a principal in a resource-based policy by using the ARN or assumed role ID. The ARN and ID include the <code>RoleSessionName</code> that you specified when you called <code>AssumeRole</code>. </p>\"\
        },\
        \"PackedPolicySize\":{\
          \"shape\":\"nonNegativeIntegerType\",\
          \"documentation\":\"<p>A percentage value that indicates the packed size of the session policies and session tags combined passed in the request. The request fails if the packed size is greater than 100 percent, which means the policies and tags exceeded the allowed space.</p>\"\
        },\
        \"SourceIdentity\":{\
          \"shape\":\"sourceIdentityType\",\
          \"documentation\":\"<p>The source identity specified by the principal that is calling the <code>AssumeRole</code> operation.</p> <p>You can require users to specify a source identity when they assume a role. You do this by using the <code>sts:SourceIdentity</code> condition key in a role trust policy. You can use source identity information in CloudTrail logs to determine who took actions with a role. You can use the <code>aws:SourceIdentity</code> condition key to further control access to Amazon Web Services resources based on the value of source identity. For more information about using source identity, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_monitor.html\\\">Monitor and control actions taken with assumed roles</a> in the <i>IAM User Guide</i>.</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>AssumeRole</a> request, including temporary Amazon Web Services credentials that can be used to make Amazon Web Services requests. </p>\"\
    },\
    \"AssumeRoleWithSAMLRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleArn\",\
        \"PrincipalArn\",\
        \"SAMLAssertion\"\
      ],\
      \"members\":{\
        \"RoleArn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the role that the caller is assuming.</p>\"\
        },\
        \"PrincipalArn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the SAML provider in IAM that describes the IdP.</p>\"\
        },\
        \"SAMLAssertion\":{\
          \"shape\":\"SAMLAssertionType\",\
          \"documentation\":\"<p>The base64 encoded SAML authentication response provided by the IdP.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/create-role-saml-IdP-tasks.html\\\">Configuring a Relying Party and Adding Claims</a> in the <i>IAM User Guide</i>. </p>\"\
        },\
        \"PolicyArns\":{\
          \"shape\":\"policyDescriptorListType\",\
          \"documentation\":\"<p>The Amazon Resource Names (ARNs) of the IAM managed policies that you want to use as managed session policies. The policies must exist in the same account as the role.</p> <p>This parameter is optional. You can provide up to 10 managed policy ARNs. However, the plaintext that you use for both inline and managed session policies can't exceed 2,048 characters. For more information about ARNs, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and Amazon Web Services Service Namespaces</a> in the Amazon Web Services General Reference.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note> <p>Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent Amazon Web Services API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>.</p>\"\
        },\
        \"Policy\":{\
          \"shape\":\"sessionPolicyDocumentType\",\
          \"documentation\":\"<p>An IAM policy in JSON format that you want to use as an inline session policy.</p> <p>This parameter is optional. Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent Amazon Web Services API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>. </p> <p>The plaintext that you use for both inline and managed session policies can't exceed 2,048 characters. The JSON policy characters can be any ASCII character from the space character to the end of the valid character list (\\\\u0020 through \\\\u00FF). It can also include the tab (\\\\u0009), linefeed (\\\\u000A), and carriage return (\\\\u000D) characters.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"roleDurationSecondsType\",\
          \"documentation\":\"<p>The duration, in seconds, of the role session. Your role session lasts for the duration that you specify for the <code>DurationSeconds</code> parameter, or until the time specified in the SAML authentication response's <code>SessionNotOnOrAfter</code> value, whichever is shorter. You can provide a <code>DurationSeconds</code> value from 900 seconds (15 minutes) up to the maximum session duration setting for the role. This setting can have a value from 1 hour to 12 hours. If you specify a value higher than this setting, the operation fails. For example, if you specify a session duration of 12 hours, but your administrator set the maximum session duration to 6 hours, your operation fails. To learn how to view the maximum value for your role, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html#id_roles_use_view-role-max-session\\\">View the Maximum Session Duration Setting for a Role</a> in the <i>IAM User Guide</i>.</p> <p>By default, the value is set to <code>3600</code> seconds. </p> <note> <p>The <code>DurationSeconds</code> parameter is separate from the duration of a console session that you might request using the returned credentials. The request to the federation endpoint for a console sign-in token takes a <code>SessionDuration</code> parameter that specifies the maximum length of the console session. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html\\\">Creating a URL that Enables Federated Users to Access the Amazon Web Services Management Console</a> in the <i>IAM User Guide</i>.</p> </note>\"\
        }\
      }\
    },\
    \"AssumeRoleWithSAMLResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Credentials\":{\
          \"shape\":\"Credentials\",\
          \"documentation\":\"<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <note> <p>The size of the security token that STS API operations return is not fixed. We strongly recommend that you make no assumptions about the maximum size.</p> </note>\"\
        },\
        \"AssumedRoleUser\":{\
          \"shape\":\"AssumedRoleUser\",\
          \"documentation\":\"<p>The identifiers for the temporary security credentials that the operation returns.</p>\"\
        },\
        \"PackedPolicySize\":{\
          \"shape\":\"nonNegativeIntegerType\",\
          \"documentation\":\"<p>A percentage value that indicates the packed size of the session policies and session tags combined passed in the request. The request fails if the packed size is greater than 100 percent, which means the policies and tags exceeded the allowed space.</p>\"\
        },\
        \"Subject\":{\
          \"shape\":\"Subject\",\
          \"documentation\":\"<p>The value of the <code>NameID</code> element in the <code>Subject</code> element of the SAML assertion.</p>\"\
        },\
        \"SubjectType\":{\
          \"shape\":\"SubjectType\",\
          \"documentation\":\"<p> The format of the name ID, as defined by the <code>Format</code> attribute in the <code>NameID</code> element of the SAML assertion. Typical examples of the format are <code>transient</code> or <code>persistent</code>. </p> <p> If the format includes the prefix <code>urn:oasis:names:tc:SAML:2.0:nameid-format</code>, that prefix is removed. For example, <code>urn:oasis:names:tc:SAML:2.0:nameid-format:transient</code> is returned as <code>transient</code>. If the format includes any other prefix, the format is returned with no modifications.</p>\"\
        },\
        \"Issuer\":{\
          \"shape\":\"Issuer\",\
          \"documentation\":\"<p>The value of the <code>Issuer</code> element of the SAML assertion.</p>\"\
        },\
        \"Audience\":{\
          \"shape\":\"Audience\",\
          \"documentation\":\"<p> The value of the <code>Recipient</code> attribute of the <code>SubjectConfirmationData</code> element of the SAML assertion. </p>\"\
        },\
        \"NameQualifier\":{\
          \"shape\":\"NameQualifier\",\
          \"documentation\":\"<p>A hash value based on the concatenation of the following:</p> <ul> <li> <p>The <code>Issuer</code> response value.</p> </li> <li> <p>The Amazon Web Services account ID.</p> </li> <li> <p>The friendly name (the last part of the ARN) of the SAML provider in IAM.</p> </li> </ul> <p>The combination of <code>NameQualifier</code> and <code>Subject</code> can be used to uniquely identify a federated user.</p> <p>The following pseudocode shows how the hash value is calculated:</p> <p> <code>BASE64 ( SHA1 ( \\\"https://example.com/saml\\\" + \\\"123456789012\\\" + \\\"/MySAMLIdP\\\" ) )</code> </p>\"\
        },\
        \"SourceIdentity\":{\
          \"shape\":\"sourceIdentityType\",\
          \"documentation\":\"<p>The value in the <code>SourceIdentity</code> attribute in the SAML assertion. </p> <p>You can require users to set a source identity value when they assume a role. You do this by using the <code>sts:SourceIdentity</code> condition key in a role trust policy. That way, actions that are taken with the role are associated with that user. After the source identity is set, the value cannot be changed. It is present in the request for all actions that are taken by the role and persists across <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts#iam-term-role-chaining\\\">chained role</a> sessions. You can configure your SAML identity provider to use an attribute associated with your users, like user name or email, as the source identity when calling <code>AssumeRoleWithSAML</code>. You do this by adding an attribute to the SAML assertion. For more information about using source identity, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_monitor.html\\\">Monitor and control actions taken with assumed roles</a> in the <i>IAM User Guide</i>.</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>AssumeRoleWithSAML</a> request, including temporary Amazon Web Services credentials that can be used to make Amazon Web Services requests. </p>\"\
    },\
    \"AssumeRoleWithWebIdentityRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleArn\",\
        \"RoleSessionName\",\
        \"WebIdentityToken\"\
      ],\
      \"members\":{\
        \"RoleArn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the role that the caller is assuming.</p>\"\
        },\
        \"RoleSessionName\":{\
          \"shape\":\"roleSessionNameType\",\
          \"documentation\":\"<p>An identifier for the assumed role session. Typically, you pass the name or identifier that is associated with the user who is using your application. That way, the temporary security credentials that your application will use are associated with that user. This session name is included as part of the ARN and assumed role ID in the <code>AssumedRoleUser</code> response element.</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        },\
        \"WebIdentityToken\":{\
          \"shape\":\"clientTokenType\",\
          \"documentation\":\"<p>The OAuth 2.0 access token or OpenID Connect ID token that is provided by the identity provider. Your application must get this token by authenticating the user who is using your application with a web identity provider before the application makes an <code>AssumeRoleWithWebIdentity</code> call. </p>\"\
        },\
        \"ProviderId\":{\
          \"shape\":\"urlType\",\
          \"documentation\":\"<p>The fully qualified host component of the domain name of the identity provider.</p> <p>Specify this value only for OAuth 2.0 access tokens. Currently <code>www.amazon.com</code> and <code>graph.facebook.com</code> are the only supported identity providers for OAuth 2.0 access tokens. Do not include URL schemes and port numbers.</p> <p>Do not specify this value for OpenID Connect ID tokens.</p>\"\
        },\
        \"PolicyArns\":{\
          \"shape\":\"policyDescriptorListType\",\
          \"documentation\":\"<p>The Amazon Resource Names (ARNs) of the IAM managed policies that you want to use as managed session policies. The policies must exist in the same account as the role.</p> <p>This parameter is optional. You can provide up to 10 managed policy ARNs. However, the plaintext that you use for both inline and managed session policies can't exceed 2,048 characters. For more information about ARNs, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and Amazon Web Services Service Namespaces</a> in the Amazon Web Services General Reference.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note> <p>Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent Amazon Web Services API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>.</p>\"\
        },\
        \"Policy\":{\
          \"shape\":\"sessionPolicyDocumentType\",\
          \"documentation\":\"<p>An IAM policy in JSON format that you want to use as an inline session policy.</p> <p>This parameter is optional. Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent Amazon Web Services API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>.</p> <p>The plaintext that you use for both inline and managed session policies can't exceed 2,048 characters. The JSON policy characters can be any ASCII character from the space character to the end of the valid character list (\\\\u0020 through \\\\u00FF). It can also include the tab (\\\\u0009), linefeed (\\\\u000A), and carriage return (\\\\u000D) characters.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"roleDurationSecondsType\",\
          \"documentation\":\"<p>The duration, in seconds, of the role session. The value can range from 900 seconds (15 minutes) up to the maximum session duration setting for the role. This setting can have a value from 1 hour to 12 hours. If you specify a value higher than this setting, the operation fails. For example, if you specify a session duration of 12 hours, but your administrator set the maximum session duration to 6 hours, your operation fails. To learn how to view the maximum value for your role, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html#id_roles_use_view-role-max-session\\\">View the Maximum Session Duration Setting for a Role</a> in the <i>IAM User Guide</i>.</p> <p>By default, the value is set to <code>3600</code> seconds. </p> <note> <p>The <code>DurationSeconds</code> parameter is separate from the duration of a console session that you might request using the returned credentials. The request to the federation endpoint for a console sign-in token takes a <code>SessionDuration</code> parameter that specifies the maximum length of the console session. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html\\\">Creating a URL that Enables Federated Users to Access the Amazon Web Services Management Console</a> in the <i>IAM User Guide</i>.</p> </note>\"\
        }\
      }\
    },\
    \"AssumeRoleWithWebIdentityResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Credentials\":{\
          \"shape\":\"Credentials\",\
          \"documentation\":\"<p>The temporary security credentials, which include an access key ID, a secret access key, and a security token.</p> <note> <p>The size of the security token that STS API operations return is not fixed. We strongly recommend that you make no assumptions about the maximum size.</p> </note>\"\
        },\
        \"SubjectFromWebIdentityToken\":{\
          \"shape\":\"webIdentitySubjectType\",\
          \"documentation\":\"<p>The unique user identifier that is returned by the identity provider. This identifier is associated with the <code>WebIdentityToken</code> that was submitted with the <code>AssumeRoleWithWebIdentity</code> call. The identifier is typically unique to the user and the application that acquired the <code>WebIdentityToken</code> (pairwise identifier). For OpenID Connect ID tokens, this field contains the value returned by the identity provider as the token's <code>sub</code> (Subject) claim. </p>\"\
        },\
        \"AssumedRoleUser\":{\
          \"shape\":\"AssumedRoleUser\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) and the assumed role ID, which are identifiers that you can use to refer to the resulting temporary security credentials. For example, you can reference these credentials as a principal in a resource-based policy by using the ARN or assumed role ID. The ARN and ID include the <code>RoleSessionName</code> that you specified when you called <code>AssumeRole</code>. </p>\"\
        },\
        \"PackedPolicySize\":{\
          \"shape\":\"nonNegativeIntegerType\",\
          \"documentation\":\"<p>A percentage value that indicates the packed size of the session policies and session tags combined passed in the request. The request fails if the packed size is greater than 100 percent, which means the policies and tags exceeded the allowed space.</p>\"\
        },\
        \"Provider\":{\
          \"shape\":\"Issuer\",\
          \"documentation\":\"<p> The issuing authority of the web identity token presented. For OpenID Connect ID tokens, this contains the value of the <code>iss</code> field. For OAuth 2.0 access tokens, this contains the value of the <code>ProviderId</code> parameter that was passed in the <code>AssumeRoleWithWebIdentity</code> request.</p>\"\
        },\
        \"Audience\":{\
          \"shape\":\"Audience\",\
          \"documentation\":\"<p>The intended audience (also known as client ID) of the web identity token. This is traditionally the client identifier issued to the application that requested the web identity token.</p>\"\
        },\
        \"SourceIdentity\":{\
          \"shape\":\"sourceIdentityType\",\
          \"documentation\":\"<p>The value of the source identity that is returned in the JSON web token (JWT) from the identity provider.</p> <p>You can require users to set a source identity value when they assume a role. You do this by using the <code>sts:SourceIdentity</code> condition key in a role trust policy. That way, actions that are taken with the role are associated with that user. After the source identity is set, the value cannot be changed. It is present in the request for all actions that are taken by the role and persists across <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts#iam-term-role-chaining\\\">chained role</a> sessions. You can configure your identity provider to use an attribute associated with your users, like user name or email, as the source identity when calling <code>AssumeRoleWithWebIdentity</code>. You do this by adding a claim to the JSON web token. To learn more about OIDC tokens and claims, see <a href=\\\"https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-tokens-with-identity-providers.html\\\">Using Tokens with User Pools</a> in the <i>Amazon Cognito Developer Guide</i>. For more information about using source identity, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_monitor.html\\\">Monitor and control actions taken with assumed roles</a> in the <i>IAM User Guide</i>.</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>AssumeRoleWithWebIdentity</a> request, including temporary Amazon Web Services credentials that can be used to make Amazon Web Services requests. </p>\"\
    },\
    \"AssumedRoleUser\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AssumedRoleId\",\
        \"Arn\"\
      ],\
      \"members\":{\
        \"AssumedRoleId\":{\
          \"shape\":\"assumedRoleIdType\",\
          \"documentation\":\"<p>A unique identifier that contains the role ID and the role session name of the role that is being assumed. The role ID is generated by Amazon Web Services when the role is created.</p>\"\
        },\
        \"Arn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The ARN of the temporary security credentials that are returned from the <a>AssumeRole</a> action. For more information about ARNs and how to use them in policies, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html\\\">IAM Identifiers</a> in the <i>IAM User Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The identifiers for the temporary security credentials that the operation returns.</p>\"\
    },\
    \"Audience\":{\"type\":\"string\"},\
    \"Credentials\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AccessKeyId\",\
        \"SecretAccessKey\",\
        \"SessionToken\",\
        \"Expiration\"\
      ],\
      \"members\":{\
        \"AccessKeyId\":{\
          \"shape\":\"accessKeyIdType\",\
          \"documentation\":\"<p>The access key ID that identifies the temporary security credentials.</p>\"\
        },\
        \"SecretAccessKey\":{\
          \"shape\":\"accessKeySecretType\",\
          \"documentation\":\"<p>The secret access key that can be used to sign requests.</p>\"\
        },\
        \"SessionToken\":{\
          \"shape\":\"tokenType\",\
          \"documentation\":\"<p>The token that users must pass to the service API to use the temporary credentials.</p>\"\
        },\
        \"Expiration\":{\
          \"shape\":\"dateType\",\
          \"documentation\":\"<p>The date on which the current credentials expire.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Amazon Web Services credentials for API authentication.</p>\"\
    },\
    \"DecodeAuthorizationMessageRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"EncodedMessage\"],\
      \"members\":{\
        \"EncodedMessage\":{\
          \"shape\":\"encodedMessageType\",\
          \"documentation\":\"<p>The encoded message that was returned with the response.</p>\"\
        }\
      }\
    },\
    \"DecodeAuthorizationMessageResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DecodedMessage\":{\
          \"shape\":\"decodedMessageType\",\
          \"documentation\":\"<p>The API returns a response with the decoded message.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A document that contains additional information about the authorization status of a request from an encoded message that is returned in response to an Amazon Web Services request.</p>\"\
    },\
    \"ExpiredTokenException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"expiredIdentityTokenMessage\"}\
      },\
      \"documentation\":\"<p>The web identity token that was passed is expired or is not valid. Get a new identity token from the identity provider and then retry the request.</p>\",\
      \"error\":{\
        \"code\":\"ExpiredTokenException\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"FederatedUser\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"FederatedUserId\",\
        \"Arn\"\
      ],\
      \"members\":{\
        \"FederatedUserId\":{\
          \"shape\":\"federatedIdType\",\
          \"documentation\":\"<p>The string that identifies the federated user associated with the credentials, similar to the unique ID of an IAM user.</p>\"\
        },\
        \"Arn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The ARN that specifies the federated user that is associated with the credentials. For more information about ARNs and how to use them in policies, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html\\\">IAM Identifiers</a> in the <i>IAM User Guide</i>. </p>\"\
        }\
      },\
      \"documentation\":\"<p>Identifiers for the federated user that is associated with the credentials.</p>\"\
    },\
    \"GetAccessKeyInfoRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"AccessKeyId\"],\
      \"members\":{\
        \"AccessKeyId\":{\
          \"shape\":\"accessKeyIdType\",\
          \"documentation\":\"<p>The identifier of an access key.</p> <p>This parameter allows (through its regex pattern) a string of characters that can consist of any upper- or lowercase letter or digit.</p>\"\
        }\
      }\
    },\
    \"GetAccessKeyInfoResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Account\":{\
          \"shape\":\"accountType\",\
          \"documentation\":\"<p>The number used to identify the Amazon Web Services account.</p>\"\
        }\
      }\
    },\
    \"GetCallerIdentityRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"GetCallerIdentityResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"UserId\":{\
          \"shape\":\"userIdType\",\
          \"documentation\":\"<p>The unique identifier of the calling entity. The exact value depends on the type of entity that is making the call. The values returned are those listed in the <b>aws:userid</b> column in the <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_variables.html#principaltable\\\">Principal table</a> found on the <b>Policy Variables</b> reference page in the <i>IAM User Guide</i>.</p>\"\
        },\
        \"Account\":{\
          \"shape\":\"accountType\",\
          \"documentation\":\"<p>The Amazon Web Services account ID number of the account that owns or contains the calling entity.</p>\"\
        },\
        \"Arn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The Amazon Web Services ARN associated with the calling entity.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>GetCallerIdentity</a> request, including information about the entity making the request.</p>\"\
    },\
    \"GetFederationTokenRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Name\"],\
      \"members\":{\
        \"Name\":{\
          \"shape\":\"userNameType\",\
          \"documentation\":\"<p>The name of the federated user. The name is used as an identifier for the temporary security credentials (such as <code>Bob</code>). For example, you can reference the federated user name in a resource-based policy, such as in an Amazon S3 bucket policy.</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        },\
        \"Policy\":{\
          \"shape\":\"sessionPolicyDocumentType\",\
          \"documentation\":\"<p>An IAM policy in JSON format that you want to use as an inline session policy.</p> <p>You must pass an inline or managed <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">session policy</a> to this operation. You can pass a single JSON policy document to use as an inline session policy. You can also specify up to 10 managed policies to use as managed session policies.</p> <p>This parameter is optional. However, if you do not pass any session policies, then the resulting federated user session has no permissions.</p> <p>When you pass session policies, the session permissions are the intersection of the IAM user policies and the session policies that you pass. This gives you a way to further restrict the permissions for a federated user. You cannot use session policies to grant more permissions than those that are defined in the permissions policy of the IAM user. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>.</p> <p>The resulting credentials can be used to access a resource that has a resource-based policy. If that policy specifically references the federated user session in the <code>Principal</code> element of the policy, the session has the permissions allowed by the policy. These permissions are granted in addition to the permissions that are granted by the session policies.</p> <p>The plaintext that you use for both inline and managed session policies can't exceed 2,048 characters. The JSON policy characters can be any ASCII character from the space character to the end of the valid character list (\\\\u0020 through \\\\u00FF). It can also include the tab (\\\\u0009), linefeed (\\\\u000A), and carriage return (\\\\u000D) characters.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note>\"\
        },\
        \"PolicyArns\":{\
          \"shape\":\"policyDescriptorListType\",\
          \"documentation\":\"<p>The Amazon Resource Names (ARNs) of the IAM managed policies that you want to use as a managed session policy. The policies must exist in the same account as the IAM user that is requesting federated access.</p> <p>You must pass an inline or managed <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">session policy</a> to this operation. You can pass a single JSON policy document to use as an inline session policy. You can also specify up to 10 managed policies to use as managed session policies. The plaintext that you use for both inline and managed session policies can't exceed 2,048 characters. You can provide up to 10 managed policy ARNs. For more information about ARNs, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and Amazon Web Services Service Namespaces</a> in the Amazon Web Services General Reference.</p> <p>This parameter is optional. However, if you do not pass any session policies, then the resulting federated user session has no permissions.</p> <p>When you pass session policies, the session permissions are the intersection of the IAM user policies and the session policies that you pass. This gives you a way to further restrict the permissions for a federated user. You cannot use session policies to grant more permissions than those that are defined in the permissions policy of the IAM user. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\\\">Session Policies</a> in the <i>IAM User Guide</i>.</p> <p>The resulting credentials can be used to access a resource that has a resource-based policy. If that policy specifically references the federated user session in the <code>Principal</code> element of the policy, the session has the permissions allowed by the policy. These permissions are granted in addition to the permissions that are granted by the session policies.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"durationSecondsType\",\
          \"documentation\":\"<p>The duration, in seconds, that the session should last. Acceptable durations for federation sessions range from 900 seconds (15 minutes) to 129,600 seconds (36 hours), with 43,200 seconds (12 hours) as the default. Sessions obtained using Amazon Web Services account root user credentials are restricted to a maximum of 3,600 seconds (one hour). If the specified duration is longer than one hour, the session obtained by using root user credentials defaults to one hour.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"tagListType\",\
          \"documentation\":\"<p>A list of session tags. Each session tag consists of a key name and an associated value. For more information about session tags, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\\\">Passing Session Tags in STS</a> in the <i>IAM User Guide</i>.</p> <p>This parameter is optional. You can pass up to 50 session tags. The plaintext session tag keys canât exceed 128 characters and the values canât exceed 256 characters. For these and additional limits, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html#reference_iam-limits-entity-length\\\">IAM and STS Character Limits</a> in the <i>IAM User Guide</i>.</p> <note> <p>An Amazon Web Services conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plaintext meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note> <p>You can pass a session tag with the same key as a tag that is already attached to the user you are federating. When you do, session tags override a user tag with the same key. </p> <p>Tag keyâvalue pairs are not case sensitive, but case is preserved. This means that you cannot have separate <code>Department</code> and <code>department</code> tag keys. Assume that the role has the <code>Department</code>=<code>Marketing</code> tag and you pass the <code>department</code>=<code>engineering</code> session tag. <code>Department</code> and <code>department</code> are not saved as separate tags, and the session tag passed in the request takes precedence over the role tag.</p>\"\
        }\
      }\
    },\
    \"GetFederationTokenResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Credentials\":{\
          \"shape\":\"Credentials\",\
          \"documentation\":\"<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <note> <p>The size of the security token that STS API operations return is not fixed. We strongly recommend that you make no assumptions about the maximum size.</p> </note>\"\
        },\
        \"FederatedUser\":{\
          \"shape\":\"FederatedUser\",\
          \"documentation\":\"<p>Identifiers for the federated user associated with the credentials (such as <code>arn:aws:sts::123456789012:federated-user/Bob</code> or <code>123456789012:Bob</code>). You can use the federated user's ARN in your resource-based policies, such as an Amazon S3 bucket policy. </p>\"\
        },\
        \"PackedPolicySize\":{\
          \"shape\":\"nonNegativeIntegerType\",\
          \"documentation\":\"<p>A percentage value that indicates the packed size of the session policies and session tags combined passed in the request. The request fails if the packed size is greater than 100 percent, which means the policies and tags exceeded the allowed space.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>GetFederationToken</a> request, including temporary Amazon Web Services credentials that can be used to make Amazon Web Services requests. </p>\"\
    },\
    \"GetSessionTokenRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DurationSeconds\":{\
          \"shape\":\"durationSecondsType\",\
          \"documentation\":\"<p>The duration, in seconds, that the credentials should remain valid. Acceptable durations for IAM user sessions range from 900 seconds (15 minutes) to 129,600 seconds (36 hours), with 43,200 seconds (12 hours) as the default. Sessions for Amazon Web Services account owners are restricted to a maximum of 3,600 seconds (one hour). If the duration is longer than one hour, the session for Amazon Web Services account owners defaults to one hour.</p>\"\
        },\
        \"SerialNumber\":{\
          \"shape\":\"serialNumberType\",\
          \"documentation\":\"<p>The identification number of the MFA device that is associated with the IAM user who is making the <code>GetSessionToken</code> call. Specify this value if the IAM user has a policy that requires MFA authentication. The value is either the serial number for a hardware device (such as <code>GAHT12345678</code>) or an Amazon Resource Name (ARN) for a virtual device (such as <code>arn:aws:iam::123456789012:mfa/user</code>). You can find the device for an IAM user by going to the Amazon Web Services Management Console and viewing the user's security credentials. </p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@:/-</p>\"\
        },\
        \"TokenCode\":{\
          \"shape\":\"tokenCodeType\",\
          \"documentation\":\"<p>The value provided by the MFA device, if MFA is required. If any policy requires the IAM user to submit an MFA code, specify this value. If MFA authentication is required, the user must provide a code when requesting a set of temporary security credentials. A user who fails to provide the code receives an \\\"access denied\\\" response when requesting resources that require MFA authentication.</p> <p>The format for this parameter, as described by its regex pattern, is a sequence of six numeric digits.</p>\"\
        }\
      }\
    },\
    \"GetSessionTokenResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Credentials\":{\
          \"shape\":\"Credentials\",\
          \"documentation\":\"<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <note> <p>The size of the security token that STS API operations return is not fixed. We strongly recommend that you make no assumptions about the maximum size.</p> </note>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>GetSessionToken</a> request, including temporary Amazon Web Services credentials that can be used to make Amazon Web Services requests. </p>\"\
    },\
    \"IDPCommunicationErrorException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"idpCommunicationErrorMessage\"}\
      },\
      \"documentation\":\"<p>The request could not be fulfilled because the identity provider (IDP) that was asked to verify the incoming identity token could not be reached. This is often a transient error caused by network conditions. Retry the request a limited number of times so that you don't exceed the request rate. If the error persists, the identity provider might be down or not responding.</p>\",\
      \"error\":{\
        \"code\":\"IDPCommunicationError\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"IDPRejectedClaimException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"idpRejectedClaimMessage\"}\
      },\
      \"documentation\":\"<p>The identity provider (IdP) reported that authentication failed. This might be because the claim is invalid.</p> <p>If this error is returned for the <code>AssumeRoleWithWebIdentity</code> operation, it can also mean that the claim has expired or has been explicitly revoked. </p>\",\
      \"error\":{\
        \"code\":\"IDPRejectedClaim\",\
        \"httpStatusCode\":403,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"InvalidAuthorizationMessageException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"invalidAuthorizationMessage\"}\
      },\
      \"documentation\":\"<p>The error returned if the message passed to <code>DecodeAuthorizationMessage</code> was invalid. This can happen if the token contains invalid characters, such as linebreaks. </p>\",\
      \"error\":{\
        \"code\":\"InvalidAuthorizationMessageException\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"InvalidIdentityTokenException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"invalidIdentityTokenMessage\"}\
      },\
      \"documentation\":\"<p>The web identity token that was passed could not be validated by Amazon Web Services. Get a new identity token from the identity provider and then retry the request.</p>\",\
      \"error\":{\
        \"code\":\"InvalidIdentityToken\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"Issuer\":{\"type\":\"string\"},\
    \"MalformedPolicyDocumentException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"malformedPolicyDocumentMessage\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the policy document was malformed. The error message describes the specific error.</p>\",\
      \"error\":{\
        \"code\":\"MalformedPolicyDocument\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"NameQualifier\":{\"type\":\"string\"},\
    \"PackedPolicyTooLargeException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"packedPolicyTooLargeMessage\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the total packed size of the session policies and session tags combined was too large. An Amazon Web Services conversion compresses the session policy document, session policy ARNs, and session tags into a packed binary format that has a separate limit. The error message indicates by percentage how close the policies and tags are to the upper size limit. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\\\">Passing Session Tags in STS</a> in the <i>IAM User Guide</i>.</p> <p>You could receive this error even though you meet other defined session policy and session tag limits. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html#reference_iam-limits-entity-length\\\">IAM and STS Entity Character Limits</a> in the <i>IAM User Guide</i>.</p>\",\
      \"error\":{\
        \"code\":\"PackedPolicyTooLarge\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"PolicyDescriptorType\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"arn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the IAM managed policy to use as a session policy for the role. For more information about ARNs, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and Amazon Web Services Service Namespaces</a> in the <i>Amazon Web Services General Reference</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A reference to the IAM managed policy that is passed as a session policy for a role session or a federated user session.</p>\"\
    },\
    \"RegionDisabledException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"regionDisabledMessage\"}\
      },\
      \"documentation\":\"<p>STS is not activated in the requested region for the account that is being asked to generate credentials. The account administrator must use the IAM console to activate STS in that region. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html\\\">Activating and Deactivating Amazon Web Services STS in an Amazon Web Services Region</a> in the <i>IAM User Guide</i>.</p>\",\
      \"error\":{\
        \"code\":\"RegionDisabledException\",\
        \"httpStatusCode\":403,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"SAMLAssertionType\":{\
      \"type\":\"string\",\
      \"max\":100000,\
      \"min\":4\
    },\
    \"Subject\":{\"type\":\"string\"},\
    \"SubjectType\":{\"type\":\"string\"},\
    \"Tag\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Key\",\
        \"Value\"\
      ],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"tagKeyType\",\
          \"documentation\":\"<p>The key for a session tag.</p> <p>You can pass up to 50 session tags. The plain text session tag keys canât exceed 128 characters. For these and additional limits, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html#reference_iam-limits-entity-length\\\">IAM and STS Character Limits</a> in the <i>IAM User Guide</i>.</p>\"\
        },\
        \"Value\":{\
          \"shape\":\"tagValueType\",\
          \"documentation\":\"<p>The value for a session tag.</p> <p>You can pass up to 50 session tags. The plain text session tag values canât exceed 256 characters. For these and additional limits, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html#reference_iam-limits-entity-length\\\">IAM and STS Character Limits</a> in the <i>IAM User Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>You can pass custom key-value pair attributes when you assume a role or federate a user. These are called session tags. You can then use the session tags to control access to resources. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\\\">Tagging Amazon Web Services STS Sessions</a> in the <i>IAM User Guide</i>.</p>\"\
    },\
    \"accessKeyIdType\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":16,\
      \"pattern\":\"[\\\\w]*\"\
    },\
    \"accessKeySecretType\":{\"type\":\"string\"},\
    \"accountType\":{\"type\":\"string\"},\
    \"arnType\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":20,\
      \"pattern\":\"[\\\\u0009\\\\u000A\\\\u000D\\\\u0020-\\\\u007E\\\\u0085\\\\u00A0-\\\\uD7FF\\\\uE000-\\\\uFFFD\\\\u10000-\\\\u10FFFF]+\"\
    },\
    \"assumedRoleIdType\":{\
      \"type\":\"string\",\
      \"max\":193,\
      \"min\":2,\
      \"pattern\":\"[\\\\w+=,.@:-]*\"\
    },\
    \"clientTokenType\":{\
      \"type\":\"string\",\
      \"max\":20000,\
      \"min\":4\
    },\
    \"dateType\":{\"type\":\"timestamp\"},\
    \"decodedMessageType\":{\"type\":\"string\"},\
    \"durationSecondsType\":{\
      \"type\":\"integer\",\
      \"max\":129600,\
      \"min\":900\
    },\
    \"encodedMessageType\":{\
      \"type\":\"string\",\
      \"max\":10240,\
      \"min\":1\
    },\
    \"expiredIdentityTokenMessage\":{\"type\":\"string\"},\
    \"externalIdType\":{\
      \"type\":\"string\",\
      \"max\":1224,\
      \"min\":2,\
      \"pattern\":\"[\\\\w+=,.@:\\\\/-]*\"\
    },\
    \"federatedIdType\":{\
      \"type\":\"string\",\
      \"max\":193,\
      \"min\":2,\
      \"pattern\":\"[\\\\w+=,.@\\\\:-]*\"\
    },\
    \"idpCommunicationErrorMessage\":{\"type\":\"string\"},\
    \"idpRejectedClaimMessage\":{\"type\":\"string\"},\
    \"invalidAuthorizationMessage\":{\"type\":\"string\"},\
    \"invalidIdentityTokenMessage\":{\"type\":\"string\"},\
    \"malformedPolicyDocumentMessage\":{\"type\":\"string\"},\
    \"nonNegativeIntegerType\":{\
      \"type\":\"integer\",\
      \"min\":0\
    },\
    \"packedPolicyTooLargeMessage\":{\"type\":\"string\"},\
    \"policyDescriptorListType\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"PolicyDescriptorType\"}\
    },\
    \"regionDisabledMessage\":{\"type\":\"string\"},\
    \"roleDurationSecondsType\":{\
      \"type\":\"integer\",\
      \"max\":43200,\
      \"min\":900\
    },\
    \"roleSessionNameType\":{\
      \"type\":\"string\",\
      \"max\":64,\
      \"min\":2,\
      \"pattern\":\"[\\\\w+=,.@-]*\"\
    },\
    \"serialNumberType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":9,\
      \"pattern\":\"[\\\\w+=/:,.@-]*\"\
    },\
    \"sessionPolicyDocumentType\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":1,\
      \"pattern\":\"[\\\\u0009\\\\u000A\\\\u000D\\\\u0020-\\\\u00FF]+\"\
    },\
    \"sourceIdentityType\":{\
      \"type\":\"string\",\
      \"max\":64,\
      \"min\":2,\
      \"pattern\":\"[\\\\w+=,.@-]*\"\
    },\
    \"tagKeyListType\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"tagKeyType\"},\
      \"max\":50\
    },\
    \"tagKeyType\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1,\
      \"pattern\":\"[\\\\p{L}\\\\p{Z}\\\\p{N}_.:/=+\\\\-@]+\"\
    },\
    \"tagListType\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Tag\"},\
      \"max\":50\
    },\
    \"tagValueType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":0,\
      \"pattern\":\"[\\\\p{L}\\\\p{Z}\\\\p{N}_.:/=+\\\\-@]*\"\
    },\
    \"tokenCodeType\":{\
      \"type\":\"string\",\
      \"max\":6,\
      \"min\":6,\
      \"pattern\":\"[\\\\d]*\"\
    },\
    \"tokenType\":{\"type\":\"string\"},\
    \"urlType\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":4\
    },\
    \"userIdType\":{\"type\":\"string\"},\
    \"userNameType\":{\
      \"type\":\"string\",\
      \"max\":32,\
      \"min\":2,\
      \"pattern\":\"[\\\\w+=,.@-]*\"\
    },\
    \"webIdentitySubjectType\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":6\
    }\
  },\
  \"documentation\":\"<fullname>Security Token Service</fullname> <p>Security Token Service (STS) enables you to request temporary, limited-privilege credentials for Identity and Access Management (IAM) users or for users that you authenticate (federated users). This guide provides descriptions of the STS API. For more information about using this service, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp.html\\\">Temporary Security Credentials</a>.</p>\"\
}\
";
}

@end
