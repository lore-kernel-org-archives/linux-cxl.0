Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC62753FC
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739860011; cv=none; b=gKSAPj3/h5QrrYxSQsn/Q/2XnUTrhDmOZkpA8KKjjCZfnITWgE2zMYINJMV7Nl6QgS2URGRYEL06JFDv6Cua2/3FhsP4j1PK9AANtEaJdj6KHZjgVlDPWcjV+SefRg+XcUlARS17EBWC6iQU983LUir1qzeV4tuziz22oEHy1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739860011; c=relaxed/simple;
	bh=kC7novR6CsX4kfVrBlmCvhm87iLO8VBcGizjsm9RA4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=McCPG3WIiAdd2XUzn7Xka+uEft0/XTLrux4HjRrD0ijijNi41ji+ML8FMiNsXRex41f5t9bSLv6fNUQDdRVuODwNa8+uYf16axsoVUUtuJ9U+8/vBn2QDXcj4oDjj0pCtV85P0TACtAGCYO39d4A1eZkbRKCxbitDCszQ7nOTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lahGwxCp; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lahGwxCp"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250218062641epoutp03c5e2d8932ab8540c1a356a542ebd2971~lOXP5WOQ42391623916epoutp03W
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 06:26:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250218062641epoutp03c5e2d8932ab8540c1a356a542ebd2971~lOXP5WOQ42391623916epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739860001;
	bh=b+jLeBnDwaRrOuaQ/VUr0dbmQQ6fMmpAshyUS5b4Neg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lahGwxCpTNoMFS/gyUEeGI3kwnQ1IGh9CKIdVt0mJmqM6WikYhDB3+edRhiOIGURU
	 Yy4j89J9w3XCp9kb+HQU8YTuopm3JGO1gLgzh9/3Y3pvDs7O52gaJvevsVqcv00G8A
	 JrrX0YwRTlcxH9Mzar1eLauhjzk37xETlPARdkJM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250218062640epcas5p137c837ee3a83335a66a47e7254222987~lOXPUbGdn3099230992epcas5p1j;
	Tue, 18 Feb 2025 06:26:40 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YxqL642sSz4x9QJ; Tue, 18 Feb
	2025 06:26:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B5.28.19710.E1824B76; Tue, 18 Feb 2025 15:26:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250218062627epcas5p11d27032bbfb1875ca7d8a13f3a590ca3~lOXCyoAop3099230992epcas5p1y;
	Tue, 18 Feb 2025 06:26:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250218062627epsmtrp15356dce17275aab89f9df2d368a5276b~lOXCxs82l0980609806epsmtrp1m;
	Tue, 18 Feb 2025 06:26:27 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-a3-67b4281e7c27
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	10.D1.18729.31824B76; Tue, 18 Feb 2025 15:26:27 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250218062625epsmtip20800278b7fa1310414eec2f58d3052e7~lOXBRK4Oh1768117681epsmtip2M;
	Tue, 18 Feb 2025 06:26:25 +0000 (GMT)
Date: Tue, 18 Feb 2025 11:56:16 +0530
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands (8.2.9.9.5.3)
Message-ID: <20250218062616.6k6p4k6e2p4huwou@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250214140851.000073fe@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmuq6cxpZ0g875shbTDytafDm9h81i
	9c01jBY3D+xksli18BqbxcKNy5gszs86xWLxd9teRovjvTtYgNw57A5cHjtn3WX3aDnyltXj
	ybXNTB59W1YxekydXe/xeZNcAFtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
	kkJeYm6qrZKLT4CuW2YO0GFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3i
	xNzi0rx0vbzUEitDAwMjU6DChOyMvrNTGAse2lY8vbaRpYFxpk4XIweHhICJxMd7JV2MXBxC
	ArsZJRZt28IO4XxilFh8vImpi5ETyPnGKHG6VxXEBmn4tPkyI0R8L6PEs+/2cA1z/t5nA0mw
	CKhK3DnaDFbEJmAg8aD5ODuILSJgJPHuxiRGkAZmgZuMEo2TnoE1CAtUSvy7fZ4F5CReAWeJ
	8/8dQcK8AoISJ2c+YQGxOQUMJVb272aHOGIih8TR21AHuUh8fLCZCcIWlnh1fAtUjZTEy/42
	KLtY4tzFT4wQdo3E664VzBC2vUTrqX4wm1kgQ6Lj6CGoObISU0+tY4KI80n0/n4CFeeV2DEP
	xAaFnIrE0reZMKu+PGuGGu8h0fpmNTMkTN4wSrztvso6gVFuFpJ3ZiFZB2FbSXR+aGKdBTSW
	WUBaYvk/DghTU2L9Lv0FjKyrGCVTC4pz01OTTQsM81LL4TGcnJ+7iRGcULVcdjDemP9P7xAj
	EwfjIUYJDmYlEd5DXRvShXhTEiurUovy44tKc1KLDzGaAqNnIrOUaHI+MKXnlcQbmlgamJiZ
	mZlYGpsZKonzNu9sSRcSSE8sSc1OTS1ILYLpY+LglGpgOttvIa208LvAmdkvpv84e9Znwrsp
	uuq90i8i3ThVbteWhpZ877pauFajNG5T9i3mJXKaLztvril8OUdge7XP0/lnZC47h7bseNgz
	RUuz0VDr+nE3Fako1dXy6TtnuU5a/F7jjopZeK7lHelz3VJr533aIyy39bPJn0XW/hMK+GOv
	LYn4cbEy97WnlWLTfz3lEOH3GvmRH1/yfLron795y+rni1MULDYsO3f9/vTrR5etFP7+L/GF
	XHj1wk37Dzbsltyk5bGRr7P/ldOJg+cfr9q77MhFjgkKuiu3tu7ZcjbzYgWjUabjdZnbOfrf
	+k/sfBLKeM8xMOtPrxn7t+7pbtqet3NL7nTcs3/iqtDxuFWJpTgj0VCLuag4EQADIzG9MQQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvK6wxpZ0gx8TuSymH1a0+HJ6D5vF
	6ptrGC1uHtjJZLFq4TU2i4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu0XLkLavH
	k2ubmTz6tqxi9Jg6u97j8ya5ALYoLpuU1JzMstQifbsErozVb3+zFUy2rngxfylbA+NTzS5G
	Tg4JAROJT5svM3YxcnEICexmlLh3bBkbREJK4tjOn1C2sMTKf8/ZQWwhgQ+MEk//cILYLAKq
	EneONjOC2GwCBhIPmo+D1YgIGEm8uzEJbCizwG1Gid+777GAJIQFKiX+3T4PZHNw8Ao4S5z/
	7wix+A2jxI+vvWA1vAKCEidnPgGzmQXMJOZtfsgMUs8sIC2x/B8HSJhTwFBiZf9u9gmMArOQ
	dMxC0jELoWMBI/MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgeNDS3MG4fdUHvUOM
	TByMhxglOJiVRHgPdW1IF+JNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1
	CCbLxMEp1cCkZ6Ezk3HBy57V9UH73p8uOJ5/Oit+zY34d2uv/dny0dDVfMb8O4/d65vu+BZ9
	nWaz49Ku9/IPljB4PpvbsXtu6N2uSQ9NWTobk8KvFEkdWLBoRU+veZynylJBV5fmutM6nuv2
	OsvO8U+Y2975t+XNWe6p595bb+Mz/ikjGSORe/SW78IvTT8Wf6ia2Cu9hG+5cNP66/xv3qZ8
	vNXW3bxn5pvlVqV2mUnnn02L4mJSnfq49c2snumFxwU09Sc+aTfYGX5j4pFEqfc7auJ9BdRv
	tXQue/TB8I/78k2XjsfPXO3kVPgz9L2JvMhFRY6HC0rKbVZvWvH4SX3ah+STGyuspCW4XxyU
	O5P16/qxqSkXFiixFGckGmoxFxUnAgC9D+UH9gIAAA==
X-CMS-MailID: 20250218062627epcas5p11d27032bbfb1875ca7d8a13f3a590ca3
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----knAlFONTECbX-FcfvlefBkarukSN3r7qQKLuxxl86w44aglH=_6267d_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213091629epcas5p1e5435929f701840a7e13f22a83edff22
References: <20250213091558.2294806-1-vinayak.kh@samsung.com>
	<CGME20250213091629epcas5p1e5435929f701840a7e13f22a83edff22@epcas5p1.samsung.com>
	<20250213091558.2294806-2-vinayak.kh@samsung.com>
	<20250214140851.000073fe@huawei.com>

------knAlFONTECbX-FcfvlefBkarukSN3r7qQKLuxxl86w44aglH=_6267d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 14/02/25 02:08PM, Jonathan Cameron wrote:
>On Thu, 13 Feb 2025 14:45:56 +0530
>Vinayak Holikatti <vinayak.kh@samsung.com> wrote:
>
>> CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.
>
>Given the CXL consortium only makes the latest spec available,
>generally we try to reference that.
>It's move to 8.2.10.9.5.3 in r3.2
>
>Otherwise mostly minor style comments inline.
>
>Thanks,
>
>Jonathan
>
Thank You for feed back will update accordingly in V3
>
>
>> CXL devices supports media operations discovery command.
>>
>> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c | 136 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 136 insertions(+)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 9c7ea5bc35..fa38ecf507 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -89,6 +89,7 @@ enum {
>>      SANITIZE    = 0x44,
>>          #define OVERWRITE     0x0
>>          #define SECURE_ERASE  0x1
>> +        #define MEDIA_OPERATIONS 0x2
>>      PERSISTENT_MEM = 0x45,
>>          #define GET_SECURITY_STATE     0x0
>>      MEDIA_AND_POISON = 0x43,
>> @@ -1721,6 +1722,137 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_BG_STARTED;
>>  }
>>
>> +#define CXL_CACHELINE_SIZE 64
>
>Already defined in include/hw/cxl/cxl.h
ok 
>
>> +enum {
>> +    MEDIA_OP_CLASS_GENERAL  = 0x0,
>> +        #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
>> +    MEDIA_OP_CLASS_SANITIZE = 0x1,
>> +        #define MEDIA_OP_SAN_SUBC_SANITIZE 0x0
>> +        #define MEDIA_OP_SAN_SUBC_ZERO 0x1
>> +    MEDIA_OP_CLASS_MAX
>> +};
>> +
>> +struct media_op_supported_list_entry {
>> +    uint8_t media_op_class;
>> +    uint8_t media_op_subclass;
>> +};
>> +
>> +struct media_op_discovery_out_pl {
>> +    uint64_t dpa_range_granularity;
>> +    uint16_t total_supported_operations;
>> +    uint16_t num_of_supported_operations;
>> +    struct media_op_supported_list_entry entry[];
>> +} QEMU_PACKED;
>> +
>> +static const struct media_op_supported_list_entry media_op_matrix[] = {
>> +    {MEDIA_OP_CLASS_GENERAL, MEDIA_OP_GEN_SUBC_DISCOVERY},
>> +    {MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_SANITIZE},
>> +    {MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO}
>Add trailing comma as we may well get more of these in future.
>In general use a trailing comma whenever there isn't a definite reason
>we will never get them.
ok
>
>Also I'd prefer space after { and before } to match local style.
>    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO },
>
ok
>> +};
>> +
>> +static CXLRetCode media_operations_discovery(uint8_t *payload_in,
>> +                                                size_t len_in,
>> +                                                uint8_t *payload_out,
>> +                                                size_t *len_out)
>Align to opening bracket (just after it)
ok
>> +{
>> +    struct {
>> +        uint8_t media_operation_class;
>> +        uint8_t media_operation_subclass;
>> +        uint8_t rsvd[2];
>> +        uint32_t dpa_range_count;
>> +        struct {
>> +            uint16_t start_index;
>> +            uint16_t num_supported_ops;
>
ok
>I'd just call this num or num_ops
>
ok 
>
>> +        } discovery_osa;
>> +    } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
>> +    int count = 0;
>> +
>> +    if (len_in < sizeof(*media_op_in_disc_pl)) {
>> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>> +    }
>> +
>> +    struct media_op_discovery_out_pl *media_out_pl =
>> +                                                  (void *)payload_out;
>> +    int num_ops = media_op_in_disc_pl->discovery_osa.num_supported_ops;
>> +    int start_index = media_op_in_disc_pl->discovery_osa.start_index;
>
>Generally we don't mix declarations and code. So move these local variable
>declarations up.
>
ok
>
>> +
>> +    if (start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +
>> +    media_out_pl->dpa_range_granularity = CXL_CACHELINE_SIZE;
>> +    media_out_pl->total_supported_operations =
>> +                                     ARRAY_SIZE(media_op_matrix);
>> +    if (num_ops > 0) {
>> +        for (int i = start_index; i < ARRAY_SIZE(media_op_matrix); i++) {
>
>Given you already checked for going out of range, can just do
>i < start_index + num_ops
>I think and avoid the need to break or keep a count.
>
ok
>Keep to local style and declare i outside the loop
>
ok
>
>> +            media_out_pl->entry[count].media_op_class =
>> +                    media_op_matrix[i].media_op_class;
>> +            media_out_pl->entry[count].media_op_subclass =
>> +                        media_op_matrix[i].media_op_subclass;
>> +            count++;
>> +            if (count == num_ops) {
>> +                break;
>> +            }
>> +        }
>> +    }
>> +
>> +    media_out_pl->num_of_supported_operations = count;
>> +    *len_out = sizeof(struct media_op_discovery_out_pl) +
>> +        (sizeof(struct media_op_supported_list_entry) * count);
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>> +static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>> +                                         uint8_t *payload_in,
>
>Alignment should be to opening bracket.
>
ok
>> +                                         size_t len_in,
>> +                                         uint8_t *payload_out,
>> +                                         size_t *len_out,
>> +                                         CXLCCI *cci)
>> +{
>> +    struct {
>> +        uint8_t media_operation_class;
>> +        uint8_t media_operation_subclass;
>> +        uint8_t rsvd[2];
>> +        uint32_t dpa_range_count;
>> +    } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
>> +
>> +    if (len_in < sizeof(*media_op_in_common_pl)) {
>> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>> +    }
>> +
>> +    uint8_t media_op_cl = media_op_in_common_pl->media_operation_class;
>> +    uint8_t media_op_subclass =
>> +                      media_op_in_common_pl->media_operation_subclass;
>> +    uint32_t dpa_range_count = media_op_in_common_pl->dpa_range_count;
>
>As above, traditional c style with declarations before code.
>
ok
>> +
>> +    switch (media_op_cl) {
>> +    case MEDIA_OP_CLASS_GENERAL:
>> +        if (media_op_subclass != MEDIA_OP_GEN_SUBC_DISCOVERY) {
>> +            return CXL_MBOX_UNSUPPORTED;
>> +        }
>> +
>> +        /*
>> +         * As per spec CXL 3.1 8.2.9.9.5.3 dpa_range_count
>> +         * should be zero for discovery sub class command
>> +         */
>
>I would move this into media_operations_discovery.
>
ok
>> +        if (dpa_range_count) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +
>> +        return media_operations_discovery(payload_in, len_in, payload_out,
>> +                                             len_out);
>> +    case MEDIA_OP_CLASS_SANITIZE:
>
>Easier to introduce this case in next patch.  Until then can just let
>the default deal with it.
>
ok
>> +        switch (media_op_subclass) {
>> +        default:
>> +            return CXL_MBOX_UNSUPPORTED;
>> +        }
>> +    default:
>> +        return CXL_MBOX_UNSUPPORTED;
>> +    }
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>
>

------knAlFONTECbX-FcfvlefBkarukSN3r7qQKLuxxl86w44aglH=_6267d_
Content-Type: text/plain; charset="utf-8"


------knAlFONTECbX-FcfvlefBkarukSN3r7qQKLuxxl86w44aglH=_6267d_--
