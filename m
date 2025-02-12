Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FC209F4B
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365706; cv=none; b=lBMrju8sKAdNelo4d+mInAcBAUQNDTTSYYQM86tTyoSoy/Cvn3a2tdhIJS5N3C3eU9A6Q0uopkboGxixKaxRIqr+iOcLqjW6dw6FrCXWYrF3YCuSCAaIedFUOU/rJgp6T/J9ZbIujyEeJgr5yJZTUstcztHdvppSM2M6VmIVWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365706; c=relaxed/simple;
	bh=CHbgW0kTNgCWTDDdpCwKXfjmxb70xvGlT1hLmAq9QAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=JK4+TjsW1sZy8r54l9iJzX5ZMn4xBtRFB1EYw6MWyejEs28qMlRvC5FNiod36d7ecvXSDWUoq8NXpNDn5+kUCTQ7qK6OTDXMIUofDen7tmYVEbHHjeSzwmM1/o8bhcK1TEUuUDh+r6mU16mazWUqK3HH6lrGFmE3r6todtA9y3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CCEDaWY7; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CCEDaWY7"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250212130822epoutp01d0b3d370004cf90dacc20041caa93bb4~jd_QPJg2_0743507435epoutp01I
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 13:08:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250212130822epoutp01d0b3d370004cf90dacc20041caa93bb4~jd_QPJg2_0743507435epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739365702;
	bh=JIUR12aJIEknI+U+0TzpDBbOGwe2AgNlCVW2ch5zdKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CCEDaWY7qWm8YazmM0g7MW7J+KK3QYIIRFzx4fDT+UIt90tQ9YVaCo+f4fb7TRe1s
	 n2CD2M6a6V1nfOoq0sjdqe8in1vQaMPXJgs23TGdlBxEj9uP1DXa6o15gJ/Ks+1iPQ
	 f6YQ0OiWdxTL3jeAIEm+kDDPz14rS2ElfCU5a0S8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250212130822epcas5p37d1dde1a418af459a90c4726a719f0d8~jd_P7O8fN2137521375epcas5p3j;
	Wed, 12 Feb 2025 13:08:22 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YtJXN6Pnwz4x9Px; Wed, 12 Feb
	2025 13:08:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.14.19710.44D9CA76; Wed, 12 Feb 2025 22:08:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250212113110epcas5p341b05ca64d755d4ff4042233de731d6b~jcpY4hXWH0678206782epcas5p3w;
	Wed, 12 Feb 2025 11:31:10 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250212113110epsmtrp100ecdcd5d1ea5a1e59424eee45eb2ee8~jcpY3zPLx0202502025epsmtrp1K;
	Wed, 12 Feb 2025 11:31:10 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-8c-67ac9d44702f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.E2.23488.E768CA76; Wed, 12 Feb 2025 20:31:10 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250212113109epsmtip1b47a0036d61e1682723fa2233d26d837~jcpXZu9Yy0638906389epsmtip1A;
	Wed, 12 Feb 2025 11:31:08 +0000 (GMT)
Date: Wed, 12 Feb 2025 17:00:57 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH 1/3] hw/cxl/cxl-mailbox-utils.c: Added support for Get
 Log Capabilities (Opcode 0402h)
Message-ID: <20250212113012.datt6a7sddkbli25@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250204102820.000047fb@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmhq7L3DXpBhtnG1tMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLVwmtsFgs3LmOyOD/rFIvF3217GS2O9+5gAXLnsDtweeycdZfdo+XIW1aP
	J9c2M3n0bVnF6DF1dr3H501yAWxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
	Sgp5ibmptkouPgG6bpk5QIcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSK
	E3OLS/PS9fJSS6wMDQyMTIEKE7IzLm9sZy+Y4ldxcu8X9gbGhdZdjJwcEgImEi0nLzB1MXJx
	CAnsZpS48raFESQhJPCJUeLsdk0I+xujxKreHJiG5xveskA07GWUuP7uIyOEA9RwYtoZdpAq
	FgFViSWfLjOB2GwCOhLnb89lA7FFBIwk3t2YBNbALHCTUaJx0jOwhLBAjsTzb3+ZQWxeAWeJ
	B7vfM0LYghInZz5hAbE5BQwlTvTcBFstIdDKITFj2RkmiJtcJPrvLmGDsIUlXh3fwg5hS0m8
	7G+DsrMl/sxvh6opkFj0cyZU3F6i9VQ/2GJmgQyJ1hMdzBBxWYmpp9YxQcT5JHp/P4HaxSux
	Yx6MrSbRvmM+1BwZiTe/FkPN95C4N2cuMyRYPjBKtFzYxjaBUW4WkodmIdkHYVtJdH5oYp3F
	yAFkS0ss/8cBYWpKrN+lv4CRdRWjZGpBcW56arJpgWFeajk8lpPzczcxghOrlssOxhvz/+kd
	YmTiYDzEKMHBrCTCKzFtTboQb0piZVVqUX58UWlOavEhRlNgDE1klhJNzgem9rySeEMTSwMT
	MzMzE0tjM0Mlcd7mnS3pQgLpiSWp2ampBalFMH1MHJxSDUzP2G/+dbgeElNn18h7qv5EnU6W
	698/fHvajy7W0DVWDKuaG/KWz8Tk9L6SHbW1039UymzIuLie9+nSqt9mV1z/66yafu6AVn5P
	dbmQQYdI0LvK50f8LyxUfFQeGdCR/HDtfqMSk9T+PilZAeN4y8L5fHZBDisY/S9OuFZfoW+a
	m/dE4So7r5q/qYf3oqnVxlNWuAaqrv1auiWqVGZ6pV0hs1mox9c7GzZb6fSu41qdNr+D5d2B
	BwnZKQHBf4VzzhQL+a4//m7D8iu8mQZ3P+4OFtfIym3itNjmfTCo8HeR/pStDp6OO6/usTrI
	c+69yY7JgutKL2VtWdr/UkBhorrqpZv+5xZcXrl9dVlKohJLcUaioRZzUXEiAJkTdLc1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnG5d25p0g/UTFSymH1a0+HJ6D5vF
	6ptrGC1uHtjJZLFq4TU2i4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu0XLkLavH
	k2ubmTz6tqxi9Jg6u97j8ya5ALYoLpuU1JzMstQifbsEroy2+RvYCo55V9zaI9jA+Naii5GT
	Q0LAROL5hrcsXYxcHEICuxklPsxeygSRkJG4OPMxC4QtLLHy33N2iKIPjBLLWj6CJVgEVCWW
	fLoM1sAmoCNx/vZcNhBbRMBI4t2NSYwgDcwCtxklfu++B9YgLJAj8fzbX2YQm1fAWeLB7veM
	cFOPtd1kgkgISpyc+QSsgVnATGLe5odADRxAtrTE8n8cIGFOAUOJEz03WSYwCsxC0jELSccs
	hI4FjMyrGCVTC4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGCI0JLYwfju29N+ocYmTgYDzFK
	cDArifCaLFyRLsSbklhZlVqUH19UmpNafIhRmoNFSZx3pWFEupBAemJJanZqakFqEUyWiYNT
	qoEpzO56QuSiirQnzqe3fD7Z+HnOZ3t+gRW9imxdXBbvzktp6E7znfdhs5/fi0flHy5y1TH+
	7T7LpN96QTzbQ/3s9aTXS90+/bgh67cg+Yf8xweK6x6liUl95j1aqRDTG7vwd1y17uOyWVNd
	PTxsvt27eUCxbsbEJ+aVrIy82oUf9n/t3THtPlPPT1OP6zdZXWZ9zrGpOZ1TM2fWM33bWwxX
	t++Qz5plXeEwp2S3qVHh+8NBPmWzdKuET3EJVgacniX4mP2S4D/JFZOmXX3VYbW2un7GiYxt
	5zoTNjamnba0EhIyDo75usri9vMN5Rcs+NhfJF4sfLtm7YvmDcyd61hMsh4ltc5+dshhVfZb
	/8kmSizFGYmGWsxFxYkA1TNxkfcCAAA=
X-CMS-MailID: 20250212113110epcas5p341b05ca64d755d4ff4042233de731d6b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_4c199_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203060051epcas5p350b7b24d3b5fcff25bc30e1acccd8121
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
	<CGME20250203060051epcas5p350b7b24d3b5fcff25bc30e1acccd8121@epcas5p3.samsung.com>
	<20250203055950.2126627-2-arpit1.kumar@samsung.com>
	<20250204102820.000047fb@huawei.com>

------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_4c199_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 04/02/25 10:28AM, Jonathan Cameron wrote:
>On Mon,  3 Feb 2025 11:29:48 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>Please add some descriptive teext here.
>
Sure, will append here in V2 patch.

>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
>> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
>
>Hi Arpit,
>
>Whilst it is good to do internal reviews, I'd prefer to see feedback
>on the mailing list if possible.  Hard for a maintainer to tell
>what a RB tag given before posting means unfortunately so in most
>cases preference is to not add RB tags based on internal review.
>If your colleagues have greatly affected the code, a
>Co-developed-by: and additional sign off may be a good way to
>reflect that.
>
>Great to have you working on these features. Some comments inline.
>Main ones are around naming (always tricky!) and suggestion to
>handle the arrays of log capabilities as static const pointers.
>
>Thanks,
>
>Jonathan
>
Thanks for the review Jonathan, will make changes accordingly in the
next iteration-V2 of the patch.
>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c   | 55 ++++++++++++++++++++++++++++++++++++
>>  include/hw/cxl/cxl_device.h  | 31 ++++++++++++++++++++
>>  include/hw/cxl/cxl_mailbox.h |  5 ++++
>>  3 files changed, 91 insertions(+)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 9c7ea5bc35..3d66a425a9 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -76,6 +76,7 @@ enum {
>>      LOGS        = 0x04,
>>          #define GET_SUPPORTED 0x0
>>          #define GET_LOG       0x1
>> +        #define GET_LOG_CAPABILITIES   0x2
>>      FEATURES    = 0x05,
>>          #define GET_SUPPORTED 0x0
>>          #define GET_FEATURE   0x1
>> @@ -1075,6 +1076,45 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +static int32_t valid_log_check(QemuUUID *uuid, CXLCCI *cci)
>
>Perhaps find_log_index() or something like that?
>I would return &ccx->supported_log_cap[i] / NULL if not found
>as then can avoid long reference into array below.
>
okay, got it.

>> +{
>> +    int32_t id = -1;
>> +    for (int i = CEL; i < MAX_LOG_TYPE; i++) {
>> +        if (qemu_uuid_is_equal(uuid,
>> +            &cci->supported_log_cap[i].uuid)) {
>> +            id = i;
>> +            break;
>> +        }
>> +    }
>> +    return id;
>> +}
>> +
>> +/* CXL r3.1 Section 8.2.9.5.3: Get Log Capabilities (Opcode 0402h) */
>
>For new documentation please use latest spec.
>This is a bit different to many other spec where the request is the
>earliest one. That is due to the consortium only making the latest
>version available (currently r3.2)
>
okay

>> +static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
>> +                                                uint8_t *payload_in,
>> +                                                size_t len_in,
>> +                                                uint8_t *payload_out,
>> +                                                size_t *len_out,
>> +                                                CXLCCI *cci)
>> +{
>> +    int32_t cap_id;
>> +    struct {
>> +        QemuUUID uuid;
>> +    } QEMU_PACKED QEMU_ALIGNED(8) * get_log_capabilities_in = (void *)payload_in;
>> +
>> +    CXLParamFlags *get_log_capabilities_out = (void *)payload_out;
>> +
>> +    cap_id = valid_log_check(&get_log_capabilities_in->uuid, cci);
>    CXLLogCapabilities *cap;
>
>    cap = find_log_cap(&get_log_capabilities_in->uuid, cci);
>    if (!cap) {
>        return CXL_MBOX_INVALID_LOG);
>    }
>
>    mempcy(get_log_capabilities_out, cap->param_flags.pflags,
>           sizeof(cap->param_flags.pflags));
>...

got it.

>
>> +    if (cap_id == -1) {
>> +        return CXL_MBOX_INVALID_LOG;
>> +    }
>> +
>> +    memcpy(get_log_capabilities_out, &cci->supported_log_cap[cap_id].param_flags.pflags,
>> +           sizeof(CXLParamFlags));
>> +    *len_out = sizeof(*get_log_capabilities_out);
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>>  /* CXL r3.1 section 8.2.9.6: Features */
>>  /*
>>   * Get Supported Features output payload
>> @@ -2840,6 +2880,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>>                                0, 0 },
>>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>> +    [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
>> +                                     cmd_logs_get_log_capabilities, 0x10, 0 },
>>      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>>                                    cmd_features_get_supported, 0x8, 0 },
>>      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
>> @@ -3084,10 +3126,23 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>>      }
>>  }
>>
>> +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
>> +    [CEL] = {.param_flags.pflags = CXL_LOG_CAP_CLEAR | CXL_LOG_CAP_POPULATE,
>> +             .uuid = cel_uuid},
>> +};
>> +
>> +static void cxl_init_get_log(CXLCCI *cci)
>> +{
>> +    for (int set = CEL; set < MAX_LOG_TYPE; set++) {
>> +        cci->supported_log_cap[set] = cxl_get_log_cap[set];
>
>As below. Can we just use a static const pointer in cci?

static const pointer in cci gives compilation error as it used below
to assign value:
     cci->supported_log_cap[set] = cxl_get_log_cap[set];

>Seems relatively unlikely we'll have lots of different log combinations
>depending on runtime configuration.  So may be better to just pick
>between a few const arrays like cxl_get_log_cap.
>
okay, will fix it in V2 patch.

>Good to also store the length of that log or use a terminating entry
>of some type so that we don't need to iterate over empty entries.
>
okay, will use terminating entry for the same.

>> +    }
>> +}
>> +
>>  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>>  {
>>      cci->payload_max = payload_max;
>>      cxl_rebuild_cel(cci);
>> +    cxl_init_get_log(cci);
>>
>>      cci->bg.complete_pct = 0;
>>      cci->bg.starttime = 0;
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index a64739be25..e7cb99a1d2 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -164,6 +164,18 @@ typedef enum {
>>      CXL_MBOX_MAX = 0x20
>>  } CXLRetCode;
>>
>> +/* types of logs */
>> +enum Logs {
>
>For things in the header please prefix with CXL.  The chances
>of a naming clash in future drivers that include this is too high
>without that!
>
>Also QEMU tends to use typedefs for enums
>
okay

>typedef enum {
>	CXL_LOG_CEL,
>	CXL_LOG_VENDOR,
>} CXLLogType;
>or something like that.
>
>Some of these abbreviations are a bit too compact and
>don't line up with spec like CEL does.,
>
okay, will update the abbreviations as per your suggestion in
V2 patch.

>
>
>
>> +    CEL,
>> +    VDL,
>> +    CSDL,
>CXL_LOG_COMPONENT_STATE_DUMP,
>> +    ECSL,
>CXL_LOG_ECS, //this one is standard acronym
>> +    MTCL,
>CXL_LOG_MEDIA_TEST_CAP
>> +    MTRSL,
>CXL_LOG_MEDIA_TEST_SHORT
>> +    MTRLL,
>CXL_LOG_MEDIA_TEST_LONG
>
>perhaps?
>> +    MAX_LOG_TYPE
>> +};
>> +
>>  typedef struct CXLCCI CXLCCI;
>>  typedef struct cxl_device_state CXLDeviceState;
>>  struct cxl_cmd;
>> @@ -194,6 +206,22 @@ typedef struct CXLEventLog {
>>      QSIMPLEQ_HEAD(, CXLEvent) events;
>>  } CXLEventLog;
>>
>> +typedef struct CXLParamFlags {
>> +    union {
>
>Unless I'm reading this wrong this is a union of lots of flags
>on top of each other.
>
>Also, don't use bitfields. They don't play well with
>different endian architectures.
>Defines for the various bits are a more reliable solution.
>Similar to the ones you have below in cxl_mailbox.h
>
okay, will fix this in V2 patch.

>
>> +        uint32_t clear_log_supported:1;
>> +        uint32_t populate_log_supported:1;
>> +        uint32_t auto_populate_supported:1;
>> +        uint32_t persistent_across_cold_reset:1;
>> +        uint32_t reserved:28;
>> +        uint32_t pflags;
>> +    };
>> +} CXLParamFlags;
>> +
>> +typedef struct CXLLogCapabilities {
>> +    CXLParamFlags param_flags;
>> +    QemuUUID uuid;
>> +} CXLLogCapabilities;
>> +
>>  typedef struct CXLCCI {
>>      struct cxl_cmd cxl_cmd_set[256][256];
>>      struct cel_log {
>> @@ -202,6 +230,9 @@ typedef struct CXLCCI {
>>      } cel_log[1 << 16];
>>      size_t cel_size;
>>
>> +    /* get log capabilities */
>> +    CXLLogCapabilities supported_log_cap[MAX_LOG_TYPE];
>Perhaps a const pointer is appropriate?

const pointer here gives compilation error as it is used below 
to assign value:
     cci->supported_log_cap[set] = cxl_get_log_cap[set];
>> +
>>      /* background command handling (times in ms) */
>>      struct {
>>          uint16_t opcode;
>> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
>> index 9008402d1c..f3502c3f68 100644
>> --- a/include/hw/cxl/cxl_mailbox.h
>> +++ b/include/hw/cxl/cxl_mailbox.h
>> @@ -16,4 +16,9 @@
>>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>>  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
>>
>> +#define CXL_LOG_CAP_CLEAR 1
>> +#define CXL_LOG_CAP_POPULATE (1 << 1)
>> +#define CXL_LOG_CAP_AUTO_POPULATE (1 << 2)
>> +#define CXL_LOG_CAP_PERSISTENT_COLD_RESET (1 << 3)
>> +
>>  #endif
>

------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_4c199_
Content-Type: text/plain; charset="utf-8"


------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_4c199_--
