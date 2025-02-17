Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69601B0421
	for <linux-cxl@vger.kernel.org>; Mon, 17 Feb 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785144; cv=none; b=M0rRGlBsemxjBiwTVyBC9XXE2Jwlriek4HZuVK8zvAuaYG1C/3cT+CDOKqld1QLO7bkSzZX24u2/Beta4FP5bRkHg74vWmZb4NgfIAE2JJI7F2ID2RplmKrxMIutVTNPAJ3q0sRtj+Dubt6Q/6+7NRMUVBA+W9aF51K80lA6ENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785144; c=relaxed/simple;
	bh=xPXOpJak1MZ8OHj+P8uX6/EB5RD4fI8BkklGBAnKea4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=gQpe7p4gbLIMQ/U/Lx7+0sCOBFYGv9zQfAnFPbP6iKlzwKupf8mQmdGmnVbuTKJNSnZhcLrW9jS4QeQ8fZuV7GGxSVYCalIgQhFIcxgnlcph49hgXBW0OfGkWdAMS2c5z1lITGckDyRc4OIOvAYJORwJ2pAPkaIdbrt0K3vMfHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=e09cMCFO; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e09cMCFO"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250217093859epoutp02d88952ee27f4aee6d852f0e1eeb095fd~k9V3ckoTB0532205322epoutp020
	for <linux-cxl@vger.kernel.org>; Mon, 17 Feb 2025 09:38:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250217093859epoutp02d88952ee27f4aee6d852f0e1eeb095fd~k9V3ckoTB0532205322epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739785139;
	bh=sy6dlm46RivPu+uzqtCThlfV9c35JXwDl1zw0oX06cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e09cMCFO6ni8nebAAf79mOjrR3QZw8hGmP/44ZGvnwDC6MY+u1/+JTptccy/h9f80
	 /mj8S/ijxfZFyK7L1kLy4Wp7ghxz6BiElkt3+tZ/CfS7hBfawR4zgCvL3nppslx777
	 ylO8vJ+GgYq7jW2jXIhiNZXm88Tum8wT5pYuBBE0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250217093859epcas5p18de803dc50e596673f94a72fe71e844a~k9V28VKxr2060920609epcas5p1G;
	Mon, 17 Feb 2025 09:38:59 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YxHfT0DLGz4x9Py; Mon, 17 Feb
	2025 09:38:57 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.D4.29212.0B303B76; Mon, 17 Feb 2025 18:38:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250217093732epcas5p34a9841ca77c60e02522232f00090074b~k9Ul_Kzke0862108621epcas5p3O;
	Mon, 17 Feb 2025 09:37:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250217093732epsmtrp16ed253934e606437dd030b0528ecf98e~k9Ul9HHEa2392023920epsmtrp1Q;
	Mon, 17 Feb 2025 09:37:32 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-5c-67b303b0afda
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F2.56.18729.B5303B76; Mon, 17 Feb 2025 18:37:31 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250217093729epsmtip2f9f3c6d990ce9ebf70633cc86f0e27da~k9Uj7XLXr0985409854epsmtip2N;
	Mon, 17 Feb 2025 09:37:29 +0000 (GMT)
Date: Mon, 17 Feb 2025 15:07:24 +0530
From: Sweta Kumari <s5.kumari@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: CXL CCI Get/Set Alert Configuration commands implmented as per
 CXL Specification 3.2 section 8.2.10.9.3
Message-ID: <20250217093724.f64zqdhk727bhk5b@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250214174359.0000368a@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmuu4G5s3pBhMum1lMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLVwmtsFgs3LmOyOD/rFIvF3217GS2O9+5gAXLnsDtweeycdZfdo+XIW1aP
	J9c2M3n0bVnF6DF1dr3H501yAWxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
	Sgp5ibmptkouPgG6bpk5QIcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSK
	E3OLS/PS9fJSS6wMDQyMTIEKE7IzZj+ZwlxwKrziwguVBsZu5y5GTg4JAROJTxsOsHYxcnEI
	CexhlLg57SI7hPOJUaKpoZEZwvnGKHHk9F4WmJZbS9vZIBJ7GSV2Lu9kgWv58+A2M0gVi4Cq
	xNfH3WAdbAJaEj8+PwCLiwgYSby7MYkRpIFZ4CajROOkZ2wgCWGBMomuGQvAGngFnCXWXVjC
	BmELSpyc+QQszilgKPFnM8SBEgK9HBLNPz+zQdzkIjH15mwmCFtY4tXxLewQtpTEy/42KDtb
	4u7WTqj6EokPt3dD1dtLtJ7qB7uOWSBD4v+iZ6wQcVmJqafWMUHE+SR6fz+BqueV2DEPxlaW
	2PJvOVS9pMSKz0ugbA+J6x+XQYNlG6PEpgl32Ccwys1C8tAsJPsgbCuJzg9NQDYHkC0tsfwf
	B4SpKbF+l/4CRtZVjFKpBcW56anJpgWGunmp5fB4Ts7P3cQITq5aATsYV2/4q3eIkYmD8RCj
	BAezkgjvoa4N6UK8KYmVValF+fFFpTmpxYcYTYFRNJFZSjQ5H5je80riDU0sDUzMzMxMLI3N
	DJXEeZt3tqQLCaQnlqRmp6YWpBbB9DFxcEo1MEV++f+f36C8/MEzDY7blvNW35K+aV2umOLw
	qlk0kqWjSqhiNXfysqhJR868lOM68Oh5xusyJT2tyQvSJjQUaB0/rNDedytt80m5XRcW8hpa
	f37BJDato/hQXc0ytsnnpqXvfy+YbLfctvlCa+qc3IAikWWrs0Inu3YFtk6QWbdr0V4+Lj6+
	0A+aN9s+tig1eEi8/2Bf/8FuldC0vghPTsE9Oj8ZwhX47PZvsEhYsuPvjw++HwLSNnQvfvC+
	0cTg06ocvj+5FRvSXi3Vi500tfvXqtgbuxim/NbRv5H701n0z03Dte1+MskvUwvby1TMmO9Y
	sbyTPWYUoefWWbYlYcbMea/frBZ2/mQ/UZupX4mlOCPRUIu5qDgRAOrfB9Q3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvG408+Z0gzvXLC2mH1a0+HJ6D5vF
	6ptrGC1uHtjJZLFq4TU2i4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu0XLkLavH
	k2ubmTz6tqxi9Jg6u97j8ya5ALYoLpuU1JzMstQifbsErow5j68zF/wJqXh6/zBbA+N1hy5G
	Tg4JAROJW0vb2boYuTiEBHYzSjx+8ZsdIiEp8fbMJUYIW1hi5b/n7BBFHxgldi5YAVbEIqAq
	8fVxNwuIzSagJfHj8wNmEFtEwEji3Y1JjCANzAK3GSV+774HViQsUCbRNWMBmM0r4Cyx7sIS
	NhBbSGAbo8S6e4UQcUGJkzOfgNUwC5hJzNv8EGgoB5AtLbH8HwdImFPAUOLP5ovsExgFZiHp
	mIWkYxZCxwJG5lWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMERoaW5g3H7qg96hxiZ
	OBgPMUpwMCuJ8B7q2pAuxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoR
	TJaJg1OqgSm62Lno74SUTobvq5a+LGV2SlnhO9dMVfnDVJuA+KX3vRdszD35xUBbucJ433ep
	7R2VS2/oyhex/S/6o+9sfPpDrEKQQr/HJin9NWvja+ZezFvSNSd/eYlG4o7jsS+/T48+dGXZ
	SZcHrmui7h9T3ND3b2psbJDE0Q93L20+JOqgqpsrGM27MJKjbllR+E/33hNWV/qqLi+uCZV/
	ccHz/umvF3SinaUdzfYuf7Foxu3UjB/ez5JqvnuJiuQw1f2zqOtZNHl/qugc+xmuSk/T7j9k
	uDuzOOH2vGePNu0XuPv91amDrh+ythxbuCds2veKCjueScEfZ+4z0V9dUrxn2aK2TuNZF5Y3
	Sy56zB9ktjtFiaU4I9FQi7moOBEAUaeNffcCAAA=
X-CMS-MailID: 20250217093732epcas5p34a9841ca77c60e02522232f00090074b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_5ebd2_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250214132317epcas5p3732f86a4aa3cee5c396e18c2bf98a82b
References: <CGME20250214132317epcas5p3732f86a4aa3cee5c396e18c2bf98a82b@epcas5p3.samsung.com>
	<20250214132211.528019-1-s5.kumari@samsung.com>
	<20250214174359.0000368a@huawei.com>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_5ebd2_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 14/02/25 05:43PM, Jonathan Cameron wrote:
>On Fri, 14 Feb 2025 18:52:11 +0530
>Sweta Kumari <s5.kumari@samsung.com> wrote:
>
>> 1)get alert configuration(Opcode 4201h)
>> 2)set alert configuration(Opcode 4202h)
>
>Move the change log to below the ---
>The key thing being git then doesn't pick it up whilst applying the patch.
>Whilst changed logs are very useful during the review process we don't
>typically want to keep them in the git history for ever!
>
>Otherwise, main comment here is shorten more names.
>
>Jonathan
>
Thank you for the feedback, will make the changes accordingly in the v3
patch.
>>
>> This v2 patch addresses the feedback from the v1 patch and include some minor new changes.
>>
>> Changes in V2:
>> - Removed cover letter as it's a single patch
>> - Added latest spec reference
>> - Fixed alignment issues
>> - Updated shorter variable names to be more descriptive
>> - Replaced field-by-field initialization in 'init_alert_config' with structured initialization for improved readability.
>> - Replaced bit fields with 'uint8_t' and added defines for individual bits.
>>
>> The patch is generated against the Johnathan's tree
>> https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.
>>
>> Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c  | 116 ++++++++++++++++++++++++++++++++++++
>>  hw/mem/cxl_type3.c          |  16 +++++
>>  include/hw/cxl/cxl_device.h |  15 +++++
>>  3 files changed, 147 insertions(+)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 9c7ea5bc35..105c63fdec 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -28,6 +28,11 @@
>>  #define CXL_DC_EVENT_LOG_SIZE 8
>>  #define CXL_NUM_EXTENTS_SUPPORTED 512
>>  #define CXL_NUM_TAGS_SUPPORTED 0
>> +#define CXL_ALERTS_LIFE_USED_WARNING_THRESHOLD (1 << 0)
>> +#define CXL_ALERTS_DEVICE_OVER_TEMP_WARNING_THRESHOLD (1 << 1)
>> +#define CXL_ALERTS_DEVICE_UNDER_TEMP_WARNING_THRESHOLD (1 << 2)
>> +#define CXL_ALERTS_CORRECTED_VOLATILE_MEMORY_ERROR_WARNING_THRESHOLD (1 << 3)
>> +#define CXL_ALERTS_CORRECTED_PERSISTENT_MEMORY_ERROR_WARNING_THRESHOLD (1 << 4)
>Let's shorten these as they are very ugly to use when a line long!
>
>#define CXL_ALERTS_OVER_TEMP_WARN_THRESH
>etc. Similar to comments below.
>
Ok, will shorten the macro names as suggested in v3 patch.
>>
>>  /*
>>   * How to add a new command, example. The command set FOO, with cmd BAR.
>> @@ -86,6 +91,9 @@ enum {
>>          #define GET_PARTITION_INFO     0x0
>>          #define GET_LSA       0x2
>>          #define SET_LSA       0x3
>> +    HEALTH_INFO_ALERTS = 0x42,
>> +        #define GET_ALERT_CONFIGURATION 0x1
>> +        #define SET_ALERT_CONFIGURATION 0x2
>CONFIG maybe enough?
>
Okay.
>>      SANITIZE    = 0x44,
>>          #define OVERWRITE     0x0
>>          #define SECURE_ERASE  0x1
>> @@ -1625,6 +1633,110 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +/* CXL r3.2 Section 8.2.10.9.3.2 Get Alert Configuration (Opcode 4201h) */
>> +static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
>> +                                       uint8_t *payload_in,
>> +                                       size_t len_in,
>> +                                       uint8_t *payload_out,
>> +                                       size_t *len_out,
>> +                                       CXLCCI *cci)
>> +{
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +    CXLAlertConfig *out = (void *)payload_out;
>
>In this case we can cast to the right type (can't do that if we don't
>name that type which happens in a lot these structures). So prefer
>    CXLAlertConfig *out = (CXLAlertConfig *)payload_out;
>
>
Okay, will fix this in v3 patch
>> +
>> +    memcpy(out, &ct3d->alert_config, sizeof(ct3d->alert_config));
>> +    *len_out = sizeof(ct3d->alert_config);
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>> +/* CXL r3.2 Section 8.2.10.9.3.3 Set Alert Configuration (Opcode 4202h) */
>> +static CXLRetCode cmd_set_alert_config(const struct cxl_cmd *cmd,
>> +                                       uint8_t *payload_in,
>> +                                       size_t len_in,
>> +                                       uint8_t *payload_out,
>> +                                       size_t *len_out,
>> +                                       CXLCCI *cci)
>> +{
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +    CXLAlertConfig *alert_config = &ct3d->alert_config;
>> +    struct {
>> +        uint8_t valid_alert_actions;
>> +        uint8_t enable_alert_actions;
>> +        uint8_t life_used_warning_threshold;
>> +        uint8_t rsvd;
>> +        uint16_t device_over_temperature_warning_threshold;
>> +        uint16_t device_under_temperature_warning_threshold;
>> +        uint16_t Corrected_volatile_memory_error_warning_threshold;
>> +        uint16_t Corrected_persistent_memory_error_warning_threshold;
>
>Shorten these as well. Similar to suggestions below.  They are
>just too long to make for nice code!
>
Got it.
>> +    } QEMU_PACKED *in = (void *)payload_in;
>> +
>> +    if (in->valid_alert_actions & CXL_ALERTS_LIFE_USED_WARNING_THRESHOLD) {
>> +        /*
>> +         * CXL 3.2 Table 8-149 The life used warning threshold shall be
>> +         * less than the life used critical alert value.
>> +         */
>> +        if (in->life_used_warning_threshold >=
>> +            alert_config->life_used_critical_alert_threshold) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +        alert_config->life_used_warning_threshold =
>> +            in->life_used_warning_threshold;
>> +        alert_config->enable_alerts |= CXL_ALERTS_LIFE_USED_WARNING_THRESHOLD;
>> +    }
>> +
>> +    if (in->valid_alert_actions &
>> +        CXL_ALERTS_DEVICE_OVER_TEMP_WARNING_THRESHOLD) {
>> +        /*
>> +         * CXL 3.2 Table 8-149 The Device Over-Temperature Warning Threshold
>> +         * shall be less than the the Device Over-Temperature Critical
>> +         * Alert Threshold.
>> +         */
>> +        if (in->device_over_temperature_warning_threshold >=
>> +            alert_config->device_over_temperature_critical_alert_threshold) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +        alert_config->device_over_temperature_warning_threshold =
>> +            in->device_over_temperature_warning_threshold;
>> +        alert_config->enable_alerts |=
>> +            CXL_ALERTS_DEVICE_OVER_TEMP_WARNING_THRESHOLD;
>> +    }
>> +
>> +    if (in->valid_alert_actions &
>> +        CXL_ALERTS_DEVICE_UNDER_TEMP_WARNING_THRESHOLD) {
>> +        /*
>> +         * CXL 3.2 Table 8-149 The Device Under-Temperature Warning Threshold
>> +         * shall be higher than the the Device Under-Temperature Critical
>> +         * Alert Threshold.
>> +         */
>> +        if (in->device_under_temperature_warning_threshold <=
>> +            alert_config->device_under_temperature_critical_alert_threshold) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +        alert_config->device_under_temperature_warning_threshold =
>> +            in->device_under_temperature_warning_threshold;
>> +        alert_config->enable_alerts |=
>> +            CXL_ALERTS_DEVICE_UNDER_TEMP_WARNING_THRESHOLD;
>> +    }
>> +
>> +    if (in->valid_alert_actions &
>> +        CXL_ALERTS_CORRECTED_VOLATILE_MEMORY_ERROR_WARNING_THRESHOLD) {
>> +        alert_config->Corrected_volatile_memory_error_warning_threshold =
>> +            in->Corrected_volatile_memory_error_warning_threshold;
>> +        alert_config->enable_alerts |=
>> +            CXL_ALERTS_CORRECTED_VOLATILE_MEMORY_ERROR_WARNING_THRESHOLD;
>> +    }
>> +
>> +    if (in->valid_alert_actions &
>> +        CXL_ALERTS_CORRECTED_PERSISTENT_MEMORY_ERROR_WARNING_THRESHOLD) {
>> +        alert_config->Corrected_persistent_memory_error_warning_threshold =
>> +            in->Corrected_persistent_memory_error_warning_threshold;
>> +        alert_config->enable_alerts |=
>> +            CXL_ALERTS_CORRECTED_PERSISTENT_MEMORY_ERROR_WARNING_THRESHOLD;
>> +    }
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>>  /* Perform the actual device zeroing */
>>  static void __do_sanitization(CXLType3Dev *ct3d)
>>  {
>> @@ -2859,6 +2971,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>>      [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
>>      [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
>>          ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
>> +    [HEALTH_INFO_ALERTS][GET_ALERT_CONFIGURATION] = {"GET_ALERT_CONFIGURATION",
>
>Space after { to match local style.
>
Ok, will address this in v3 patch.
>> +        cmd_get_alert_config, 0, 0 },
>> +    [HEALTH_INFO_ALERTS][SET_ALERT_CONFIGURATION] = {"SET_ALERT_CONFIGURATION",
>> +        cmd_set_alert_config, 12, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
>>      [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
>>          (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
>>           CXL_MBOX_SECURITY_STATE_CHANGE |
>
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index a64739be25..1da23bf553 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -581,6 +581,19 @@ typedef struct CXLSetFeatureInfo {
>>      size_t data_size;
>>  } CXLSetFeatureInfo;
>>
>> +typedef struct CXLAlertConfig {
>> +    uint8_t valid_alerts;
>> +    uint8_t enable_alerts;
>> +    uint8_t life_used_critical_alert_threshold;
>> +    uint8_t life_used_warning_threshold;
>> +    uint16_t device_over_temperature_critical_alert_threshold;
>I think we can shorten these at least a bit without lost of meaning!
>It's on a device so can drop that entirely. Perhaps
>
>    uint8_t life_used_crit_alert_thresh;
>    uint8_t life_used_warn_thresh;
>    uint16_t over_temp_crit_alert_thresh;
>    uint16_t under_temp_crit_alert_thresh;
>    uint16_t over_temp_warn_thresh;
>    uint16_t under_temp_warn_thresh;
>    uint16_t cor_volatile_mem_err_warn_thresh;
>    uint16_t cor_persistent_mem_err_warn_thresh;
>
Ok, will shorten the field names as suggested.
>> +    uint16_t device_under_temperature_critical_alert_threshold;
>> +    uint16_t device_over_temperature_warning_threshold;
>> +    uint16_t device_under_temperature_warning_threshold;
>> +    uint16_t Corrected_volatile_memory_error_warning_threshold;
>Capital in just this one doesn't make much sense.
>> +    uint16_t Corrected_persistent_memory_error_warning_threshold;
>> +} QEMU_PACKED CXLAlertConfig;
>
>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_5ebd2_
Content-Type: text/plain; charset="utf-8"


------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_5ebd2_--
