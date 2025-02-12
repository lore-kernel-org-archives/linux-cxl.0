Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C869720B21F
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365718; cv=none; b=AsLkSM9U/7bnbpEQUBa+AFabOvPgOPV5GPq5hh3vK8fL3O//uqjWmCHs4HVpkl85yd4U1Eq1FCKDTLacjVu2dKFGJ+szsFLsLAsrEmx/7xAXaitfbWInTmikZ0CDvBckrbj2ItCw7r+xFtN5PIbvm7NPV774XTKfL+RMPToHoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365718; c=relaxed/simple;
	bh=oWqeT9aoZjBBHzxUgNpkBlwdaTafNPolCtOEZbDIUAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=h48GYUEpDdU9H8SWpU2nOwmUW6x3sVEsccfgiYll2CM3Qi504aC1VaCIt9bgxIdaPJTjR/0dEGjadT0+luR7+60pLze+SnAKALsssxbe5VWN5jyphq5EFd5b6e4t1GfwQ6fi939kZNnzoZgL69H9qFroCG1Euz7CBBsgHRMbT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VMAlFFZb; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VMAlFFZb"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250212130834epoutp02684f439072e1aba6026067bf04708aa8~jd_byekj10579305793epoutp02I
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 13:08:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250212130834epoutp02684f439072e1aba6026067bf04708aa8~jd_byekj10579305793epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739365714;
	bh=B0oEDPfPQfCNVkbugaxU2CuXgm4aspBSRwQz+zy1uac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VMAlFFZb72M9f39nTEK4vhgr4E65Iz53ZpJKmXo8YUroQgdqs66uMR8tMHMLqWpWC
	 F4SHoHwAaJeCQUoWTMyx7cpY/RsKPpRasT5NUnKvShCS79Lj269TtVUsiLK3iG5bsE
	 EgyD+AcXvhVqrCPsmJRT63UnYLP/8sTSfodcQGhs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250212130834epcas5p378894a8d8377a5005bb2127fde5fe512~jd_bdf1VE2814328143epcas5p3R;
	Wed, 12 Feb 2025 13:08:34 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YtJXd1zmbz4x9Q0; Wed, 12 Feb
	2025 13:08:33 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.EF.19933.15D9CA76; Wed, 12 Feb 2025 22:08:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250212114537epcas5p20dd573ae3eaf86e8793fb035662e509f~jc1-02ssS0314703147epcas5p2u;
	Wed, 12 Feb 2025 11:45:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250212114537epsmtrp1673d524939dc7980f5aa86e1b12d1a71~jc1-0KnLP0957909579epsmtrp1E;
	Wed, 12 Feb 2025 11:45:37 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-e9-67ac9d51fe80
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C1.22.18729.0E98CA76; Wed, 12 Feb 2025 20:45:36 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250212114535epsmtip21a0d91755548700961d8145b8a0b2f0e~jc1_XFLpA2106121061epsmtip2s;
	Wed, 12 Feb 2025 11:45:35 +0000 (GMT)
Date: Wed, 12 Feb 2025 17:15:31 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH 3/3] hw/cxl/cxl-mailbox-utils.c: Added support for
 Populate Log (Opcode 0404h) as background operation
Message-ID: <20250212114531.oxjcylhvdydltoqk@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250204105829.00001c47@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmlm7g3DXpBmsecllMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLVwmtsFgs3LmOyOD/rFIvF3217GS2O9+5gAXLnsDtweeycdZfdo+XIW1aP
	J9c2M3n0bVnF6DF1dr3H501yAWxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
	Sgp5ibmptkouPgG6bpk5QIcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSK
	E3OLS/PS9fJSS6wMDQyMTIEKE7IztjW8YyuYalZxtOE4SwNjm1oXIyeHhICJxKEFp1lBbCGB
	3YwS3xepQNifGCVmn0rrYuQCsr8xSvx9tIARpuHRl/UsEEV7GSW270yFKAJqWDJjA1gRi4Cq
	xLaWRiYQm01AR+L87blsILaIgJHEuxuTGEEamAVuMko0TnoGlhAWqJF4+2Ij0BkcHLwCzhLX
	loJdwSsgKHFy5hOwZZwChhLH5t1kgTiil0Pi8nNXCNtFYvncbmYIW1ji1fEt7BC2lMTL/jYo
	O1viz/x2Ngi7QGLRz5lQcXuJ1lP9YL3MAhkSzxYfgJojKzH11DomiDifRO/vJ0wQcV6JHfNg
	bDWJ9h3zoebISLz5tRhqvofE4ws9TJBA+cAosXTdfZYJjHKzkPwzC8k+CNtKovNDE+ssoPeZ
	BaQllv/jgDA1Jdbv0l/AyLqKUTK1oDg3PbXYtMAoL7UcHsXJ+bmbGMEpVctrB+PDBx/0DjEy
	cTAeYpTgYFYS4ZWYtiZdiDclsbIqtSg/vqg0J7X4EKMpMH4mMkuJJucDk3peSbyhiaWBiZmZ
	mYmlsZmhkjhv886WdCGB9MSS1OzU1ILUIpg+Jg5OqQamDX9cffdcWXo5rDjfTOrPNI5stcaO
	rbOefOVc3bfAp6ij7Wm9zoX5d55+mLBq6c3+fdwZhzXnrTXZ+f/cias3Kg0C3L16y0/25vo+
	2ub7QrZ+87/ypXPa/x29lvw913K72v9ghUP/ruvK7+n5xre31ll2kf1VP+OdC9+YLEgs6/Pw
	6alRX+7Aa3OP00P9glCNn7yc+lRhXud9bp5zK2cpXZQKFVlaf2HjRPMj0xnWVp9qrfQ16RUq
	ZEx15/N899o+/P05bZ6g0yFVPMId17d8PxobM/mh5i7OvU5LPx5XOFwQwVvWyi1YuHpH0PNa
	r6Q41RVnKk8Hptj1OK78s2fBij3aK47czuPZ1Pipjb9ZiaU4I9FQi7moOBEASjWF1DIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvO6DzjXpBnfWW1lMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLVwmtsFgs3LmOyOD/rFIvF3217GS2O9+5gAXLnsDtweeycdZfdo+XIW1aP
	J9c2M3n0bVnF6DF1dr3H501yAWxRXDYpqTmZZalF+nYJXBlr1z1hKThuXHHreAtbA+Ml5S5G
	Tg4JAROJR1/Ws3QxcnEICexmlPjTs4gdIiEjcXHmYxYIW1hi5b/n7BBFHxgl5vzdzwSSYBFQ
	ldjW0ghmswnoSJy/PZcNxBYRMJJ4d2MSI0gDs8BtRonfu++BTRIWqJF4+2IjaxcjBwevgLPE
	taUqIGGwodc2B4HYvAKCEidnPgErZxYwk5i3+SEzSDmzgLTE8n8cIGFOAUOJY/NuskxgFJiF
	pGMWko5ZCB0LGJlXMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEx4OW5g7G7as+6B1i
	ZOJgPMQowcGsJMJrsnBFuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWp
	RTBZJg5OqQYm7q1/Fj17atbtqPF4rd7G90ZHuvcFR50sfr/qRm3TH93EwJ8bP5XOWCXcG11/
	/EPV2VdnwrWO18fUfb7dZe/PkHlb7Fo01+cYdoGLzt7BHBNmadvEO3xeyxItYpB7eELUCcUr
	yrsOWNcb3l66f8ndeSH68quzopZPceBNiNhR59bpz3B8wVTndf1+p9kvlSaUbU39o5n06ZpD
	x6FlfqG1Kq6SW2Or9TmtN0qfrah8Pee6/r3b4bISk1eGXii3fTJxYZWJ0/S67HmzTr8XUlTV
	Wftz8rkttn/atjEeyPzTz7D8qaZGA0v94Yf8RfqfJctafiquO2gqXK9lMtFaf8ZizVMXD3ZU
	SNhFWVUwxM5VYinOSDTUYi4qTgQApW7D4/YCAAA=
X-CMS-MailID: 20250212114537epcas5p20dd573ae3eaf86e8793fb035662e509f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_4c391_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203060055epcas5p4a7889ddf3b73b10f8b9b41778375ce63
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
	<CGME20250203060055epcas5p4a7889ddf3b73b10f8b9b41778375ce63@epcas5p4.samsung.com>
	<20250203055950.2126627-4-arpit1.kumar@samsung.com>
	<20250204105829.00001c47@huawei.com>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_4c391_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 04/02/25 10:58AM, Jonathan Cameron wrote:
>On Mon,  3 Feb 2025 11:29:50 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
>> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
>
>Likewise, the CEL isn't a dynamic thing.  Asking to populate
>it makes little sense so the log capability should always
>say this is not supported.
>
>I suspect you had this running with a different log and flipped
>to CEL for purposes of up streaming?
>
>Anyhow, choose something else.  Maybe component state dump or ECS log?
>
Thanks for the review Jonathan, will update the same in V2 patch 
and return unsupported for CEL.
>> ---
>>  hw/cxl/cxl-mailbox-utils.c  | 95 +++++++++++++++++++++++++++++++++++++
>>  include/hw/cxl/cxl_device.h |  2 +
>>  2 files changed, 97 insertions(+)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 5fd7f850c4..115c2dc66b 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -78,6 +78,7 @@ enum {
>>          #define GET_LOG       0x1
>>          #define GET_LOG_CAPABILITIES   0x2
>>          #define CLEAR_LOG     0x3
>> +        #define POPULATE_LOG  0x4
>>      FEATURES    = 0x05,
>>          #define GET_SUPPORTED 0x0
>>          #define GET_FEATURE   0x1
>> @@ -1149,6 +1150,94 @@ static CXLRetCode cmd_logs_clear_log(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +static void cxl_rebuild_cel(CXLCCI *cci);
>> +
>> +static int get_populate_duration(uint32_t total_mem)
>> +{
>> +    int secs = 0;
>> +
>> +    if (total_mem <= 512) {
>> +        secs = 4;
>> +    } else if (total_mem <= 1024) {
>> +        secs = 8;
>> +    } else if (total_mem <= 2 * 1024) {
>> +        secs = 15;
>> +    } else if (total_mem <= 4 * 1024) {
>> +        secs = 30;
>> +    } else if (total_mem <= 8 * 1024) {
>> +        secs = 60;
>> +    } else if (total_mem <= 16 * 1024) {
>> +        secs = 2 * 60;
>> +    } else if (total_mem <= 32 * 1024) {
>> +        secs = 4 * 60;
>> +    } else if (total_mem <= 64 * 1024) {
>> +        secs = 8 * 60;
>> +    } else if (total_mem <= 128 * 1024) {
>> +        secs = 15 * 60;
>> +    } else if (total_mem <= 256 * 1024) {
>> +        secs = 30 * 60;
>> +    } else if (total_mem <= 512 * 1024) {
>> +        secs = 60 * 60;
>> +    } else if (total_mem <= 1024 * 1024) {
>> +        secs = 120 * 60;
>> +    } else {
>> +        secs = 240 * 60; /* max 4 hrs */
>> +    }
>> +
>> +    return secs;
>> +}
>> +
>> +/* CXL r3.1 Section 8.2.9.5.5: Populate log (Opcode 0404h) */
>> +static CXLRetCode cmd_logs_populate_log(const struct cxl_cmd *cmd,
>> +                                        uint8_t *payload_in,
>> +                                        size_t len_in,
>> +                                        uint8_t *payload_out,
>> +                                        size_t *len_out,
>> +                                        CXLCCI *cci)
>> +{
>> +    int32_t cap_id;
>> +    uint32_t total_mem = 0;
>> +    int secs = 0;
>> +    struct {
>> +        QemuUUID uuid;
>> +    } QEMU_PACKED QEMU_ALIGNED(8) * populate_log = (void *)payload_in;
>> +
>> +    cap_id = valid_log_check(&populate_log->uuid, cci);
>> +    if (cap_id == -1) {
>> +        return CXL_MBOX_INVALID_LOG;
>> +    }
>> +
>> +    if (cci->supported_log_cap[cap_id].param_flags.populate_log_supported) {
>> +        switch (cap_id) {
>> +        case CEL:
>Similar to before, a callback to fill the log inside the cap entry
>is probably going to be the most extensible way to do this rather
>than using an ID and a switch statement that gets steadily more
>complex and doesn't easily allow for different device emulation to
>make different choices on what to fill with (e.g. faking component
>state dump for a type 3 vs a type 2 device - once supported in qemu).
>
okay

>> +            cci->log = CEL;
>> +            total_mem = (1 << 16) * sizeof(struct cel_log);
>> +            secs = get_populate_duration(total_mem >> 20);
>
>Why would the CEL be based on memory size?
>
CEL is not dependent on memory size. It is representing CEL buffer size. 
total_mem variable is misleading in this case. will take care in next
iteration.
>> +            goto start_bg;
>> +            break;
>> +        default:
>> +            return CXL_MBOX_UNSUPPORTED;
>> +        }
>> +    }
>> +    return CXL_MBOX_UNSUPPORTED;
>> +
>> +start_bg:
>> +    cci->bg.runtime = secs * 1000UL;
>> +    *len_out = 0;
>> +    return CXL_MBOX_BG_STARTED;
>> +}
>> +
>> +static void __do_populate(CXLCCI *cci)
>> +{
>> +    switch (cci->log) {
>> +    case CEL:
>> +        cxl_rebuild_cel(cci);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +}
>> +
>>  /* CXL r3.1 section 8.2.9.6: Features */
>>  /*
>>   * Get Supported Features output payload
>> @@ -2918,6 +3007,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>>                                       cmd_logs_get_log_capabilities, 0x10, 0 },
>>      [LOGS][CLEAR_LOG] = { "LOGS_CLEAR_LOG", cmd_logs_clear_log, 0x10,
>>                            CXL_MBOX_IMMEDIATE_LOG_CHANGE},
>> +    [LOGS][POPULATE_LOG] = { "LOGS_POPULATE_LOG", cmd_logs_populate_log, 0x10,
>> +                             (CXL_MBOX_IMMEDIATE_LOG_CHANGE |
>> +                              CXL_MBOX_BACKGROUND_OPERATION)},
>>      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>>                                    cmd_features_get_supported, 0x8, 0 },
>>      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
>> @@ -3098,6 +3190,9 @@ static void bg_timercb(void *opaque)
>>          case 0x0201: /* fw transfer */
>>              __do_firmware_xfer(cci);
>>              break;
>> +        case 0x0404: /* populate_ log */
>> +            __do_populate(cci);
>> +            break;
>>          case 0x4400: /* sanitize */
>>          {
>>              CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index e7cb99a1d2..d90d0d4a8f 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -230,6 +230,8 @@ typedef struct CXLCCI {
>>      } cel_log[1 << 16];
>>      size_t cel_size;
>>
>> +    enum Logs log;
>> +
>>      /* get log capabilities */
>>      CXLLogCapabilities supported_log_cap[MAX_LOG_TYPE];
>>
>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_4c391_
Content-Type: text/plain; charset="utf-8"


------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_4c391_--
