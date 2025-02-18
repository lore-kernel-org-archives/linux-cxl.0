Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593687482
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739860524; cv=none; b=MZZZUztCVwpfHxVwRyzBN+81b/1AXr0tEZCoCbBkTeGr8B4taeX4LywK1MVrw7KrwNaxVgCbky3IahpNGhh5IGn9pX+OeKLrqCV8uPlIGdxzzKiX3x1TZZpqO3vF0cfygdMTJxdYRHdRW3Ggiy5pcNBfN0BpkDU92XMc/7qL2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739860524; c=relaxed/simple;
	bh=P0O6OZ7w8QKezt3wARJBLClzR9xHR1etZVYqpoSx75w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=CE7nzVH/ufDosyq3RULlG57HaoCkrf4Cm2pObFguHwPc9veydow2Svi2T//u8jk5zROa4gZnARpI/SVqMXpnAvlCA2UFjy4dbmtl33FdMW1MzBn5VnJ+Qx0cKaXAVHsZ/3nYJKYdhcfowcGc6loJScCBOk9pL1psmBZgSnJDyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pjFeIwHh; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pjFeIwHh"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250218063519epoutp02b5f2c71748e73e582b3997d419b1c344~lOeySasgH0239002390epoutp02D
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 06:35:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250218063519epoutp02b5f2c71748e73e582b3997d419b1c344~lOeySasgH0239002390epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739860519;
	bh=kxLXLTaipK9NvSvIBbpusfTX0FTRfA810yNwfQYXV9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pjFeIwHhRahuGByldpo4fP4a2eGHq7Ef89UHyjIDni8fwM5ETCOyu0nBZvFQ8n8mE
	 jY2Kz+KpJ/QsMa2mSMPWMGc+pQWKj+EboprDA3weykKZMXjmmnRxljCD179DA0iBku
	 dfHNTtfN3/BI94A0kbJd9mqx+pM12vcLvN9bYPWo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250218063519epcas5p45334159e0be8606b14f04b2ef067010c~lOeyCHa2n3065030650epcas5p4q;
	Tue, 18 Feb 2025 06:35:19 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YxqX45q1yz4x9Q1; Tue, 18 Feb
	2025 06:35:16 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.66.29212.42A24B76; Tue, 18 Feb 2025 15:35:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250218063456epcas5p413d843dc7ea0e14c6209cfb70d0e921e~lOedA6XoH2881028810epcas5p4x;
	Tue, 18 Feb 2025 06:34:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250218063456epsmtrp18c7a52d34370f49f362bcef22e9de53c~lOedALZHm1527615276epsmtrp1T;
	Tue, 18 Feb 2025 06:34:56 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-a7-67b42a2427c5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	19.E2.18729.01A24B76; Tue, 18 Feb 2025 15:34:56 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250218063454epsmtip2d4865ec0e6013a4bc0b0f21264257000~lOebe_MEF2300323003epsmtip2O;
	Tue, 18 Feb 2025 06:34:54 +0000 (GMT)
Date: Tue, 18 Feb 2025 12:04:49 +0530
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH v2 3/3] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Message-ID: <20250218063449.awya3h57p4qn3yak@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250214144005.000018d2@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmpq6K1pZ0g1srtC2mH1a0+HJ6D5vF
	6ptrGC1uHtjJZLFq4TU2i4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu0XLkLavH
	k2ubmTz6tqxi9Jg6u97j8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
	JYW8xNxUWyUXnwBdt8wcoMOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrF
	ibnFpXnpenmpJVaGBgZGpkCFCdkZvzemFPxMq3h3rIWlgXGCexcjJ4eEgInExAnTmLsYuTiE
	BPYwSrxctoMJwvnEKPG0YRobhPONUWLZqiWMMC0LFiyESuxllHhzcgI7XMu76/3MIFUsAqoS
	79o3sIHYbAIGEg+aj7OD2CICRhLvbkxiBGlgFrjJKNE46RnYKGGBDkaJ5r1vwHbwCjhLXN60
	ggnCFpQ4OfMJC4jNKWAosXbeUbBuCYFODom3PQ9ZII5ykZh77zoThC0s8er4FnYIW0riZX8b
	lF0sce7iJ6gnaiRed61ghrDtJVpPgZzNAXRShsTST7YQYVmJqafWgY1kFuCT6P39BGo8r8SO
	eSA2B5CtIrH0bSbMpi/Pmhkhwh4Sp+6VQALlDaPEwXerWCcwys1C8s0shGWzwBZYSXR+aGKF
	CEtLLP/HAWFqSqzfpb+AkXUVo1RqQXFuemqyaYGhbl5qOTySk/NzNzGC06pWwA7G1Rv+6h1i
	ZOJgPMQowcGsJMJ7qGtDuhBvSmJlVWpRfnxRaU5q8SFGU2D8TGSWEk3OByb2vJJ4QxNLAxMz
	MzMTS2MzQyVx3uadLelCAumJJanZqakFqUUwfUwcnFINTEvWKEbKHmQOO6u7jDlWOkvg2VKh
	TzOvLd382WeDhgOfmPKRljPbDr13jPt5Jzq7LsWF2/XNWpM27Q8s1i9q/y8V6dsg9H7GcQfr
	zkCN2z8nzr8R3K3c11Av2mEhNnmmwo/0eYpCC/aavA2LXOguWcUoddckR9Dl4cftl61O/jkt
	xbSf+W0mt+xMSY3S4/f+he326VSczHNS8cWtlX/7Gvbks544kuYjncAXku+YMNMxPuKmO4Oe
	4uTQh+9qWFklbXZNuqKh6C695vLDZJGi1Mc3TCz3rtp08GXwuT1Wkwx184X3JS4wZmF5kqxx
	S/uy8q9Pjw4tWdXFLXj12+29udParkT9SH8tv/VchrSAthJLcUaioRZzUXEiAOkDUdg0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvK6A1pZ0gzl/RC2mH1a0+HJ6D5vF
	6ptrGC1uHtjJZLFq4TU2i4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu0XLkLavH
	k2ubmTz6tqxi9Jg6u97j8ya5ALYoLpuU1JzMstQifbsErozjvx8wF6xOqdh0j7eB8Y5LFyMn
	h4SAicSCBQvZQGwhgd2MEqseM0HEpSSO7fzJBmELS6z895y9i5ELqOYDo8Sc9afAilgEVCXe
	tW8AK2ITMJB40HycHcQWETCSeHdjEiNIA7PAbUaJ37vvsYA4wgIdjBLNe98wglTxCjhLXN60
	ggli7BtGiVt9S6ESghInZz5hAbGZBcwk5m1+yNzFyAFkS0ss/8cBEuYUMJRYO+8o4wRGgVlI
	OmYh6ZiF0LGAkXkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwRGhp7mDcvuqD3iFG
	Jg7GQ4wSHMxKIryHujakC/GmJFZWpRblxxeV5qQWH2KU5mBREucVf9GbIiSQnliSmp2aWpBa
	BJNl4uCUamC6lMlbOWdnkZJq+cWmrAexHzQcKqznf7t7OHvvQY+mFvmMF48kr8q0lDtvk7+/
	sfmbkc8sTaO/epfSmpd5qGfLPDtSHXgsrzt33oEXPxqKxM6cYfkox5UqIvgv6vtv1YthswVP
	rWqerqOhKMqkU+jrLtxsUeZ96/cH/20sarnapyZv3TB1Tf5K3wU1Z/Ueu7JunlHOU2bQ+8Vv
	bhVb6lHBeUqVjae/yPKeyTEtCZW6Xtlioajdv3KOYsP1h2rqbgn6C7iLFabLsqnbmrFmyN2z
	Fah+0Geq5WB0Z+W+PeWqP574pP28ymsTtdT86+eMacWZc4yu/3afOtXkacs2ljO/Eup2va3e
	l+x+ScOqWYmlOCPRUIu5qDgRANNsTN33AgAA
X-CMS-MailID: 20250218063456epcas5p413d843dc7ea0e14c6209cfb70d0e921e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_629ef_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213091632epcas5p2726909f864b50cc2d1b7ceb2415698c2
References: <20250213091558.2294806-1-vinayak.kh@samsung.com>
	<CGME20250213091632epcas5p2726909f864b50cc2d1b7ceb2415698c2@epcas5p2.samsung.com>
	<20250213091558.2294806-4-vinayak.kh@samsung.com>
	<20250214144005.000018d2@huawei.com>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_629ef_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 14/02/25 02:40PM, Jonathan Cameron wrote:
>On Thu, 13 Feb 2025 14:45:58 +0530
>Vinayak Holikatti <vinayak.kh@samsung.com> wrote:
>
>> CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.
>As in previous - please update to the r3.2 spec.
>
ok will update as per 3.2
>A few comments inline.
>
>Thanks,
>
>Jonathan
>
Thank you for feedback will address them in V3 patch

>> CXL devices supports media operations Sanitize and Write zero command.
>>
>> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c  | 217 +++++++++++++++++++++++++++++++++++-
>>  include/hw/cxl/cxl_device.h |   4 +
>>  2 files changed, 216 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index d58c20842f..2d8d1171b4 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -1732,6 +1732,130 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>>  }
>>
>>  #define CXL_CACHELINE_SIZE 64
>> +struct CXLSanitizeInfo {
>> +    uint32_t dpa_range_count;
>> +    uint8_t fill_value;
>> +    struct {
>> +            uint64_t starting_dpa;
>> +            uint64_t length;
>> +    } dpa_range_list[];
>> +};
>> +
>> +struct dpa_range_list_entry {
>> +    uint64_t starting_dpa;
>> +    uint64_t length;
>> +};
>
>Declare it above and use in CXLSanitizeInfo
>
ok
>> +
>> +static uint64_t get_vmr_size(CXLType3Dev *ct3d, MemoryRegion **vmr)
>> +{
>> +    uint64_t vmr_size = 0;
>> +    if (ct3d->hostvmem) {
>> +        *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
>> +        vmr_size = memory_region_size(*vmr);
>> +    }
>> +    return vmr_size;
>> +}
>> +
>
>I would write as
>
>static uint64_t get_pmr_size(CXLTYpe3Dev *ct3d, MemoryRegion **pmr)
>{
>    MemoryRegion *mr;
>    if (ct3d->hostpmem) {
>        mr = host_memory_region_backend_get_memory(ct3d->hostpmem);
>        if (pmr) {
>            *pmr = mr;
>        }
>	return memory_region_size(mr);
>    }
>    return 0;
>}
>
ok
>Making the pmr argument optional for when you don't need it.
>
>> +static uint64_t get_pmr_size(CXLType3Dev *ct3d, MemoryRegion **pmr)
>> +{
>> +    uint64_t pmr_size = 0;
>> +    if (ct3d->hostpmem) {
>> +        *pmr = host_memory_backend_get_memory(ct3d->hostpmem);
>> +        pmr_size = memory_region_size(*pmr);
>> +    }
>> +    return pmr_size;
>> +}
>> +
>> +static uint64_t get_dc_size(CXLType3Dev *ct3d, MemoryRegion **dc_mr)
>> +{
>> +    uint64_t dc_size = 0;
>> +    if (ct3d->dc.host_dc) {
>> +        *dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
>> +        dc_size = memory_region_size(*dc_mr);
>> +    }
>> +    return dc_size;
>> +}
>> +
>> +static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
>> +                             size_t length)
>> +{
>> +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
>> +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
>
>overwritten in all paths were we use them. So don't assign initial values.
>
ok
>> +
>> +    if ((dpa_addr % CXL_CACHELINE_SIZE) ||
>> +         (length % CXL_CACHELINE_SIZE)  ||
>> +         (length <= 0)) {
>Align as
>    if ((dpa_addr % CXL_CACHELINE_SIZE) ||
>        (length % CXL_CACHELINE_SIZE) ||
>        (length <= 0)) {
>
ok
>> +        return -EINVAL;
>> +    }
>> +
>> +    vmr_size = get_vmr_size(ct3d, &vmr);
>> +    pmr_size = get_pmr_size(ct3d, &pmr);
>> +    dc_size = get_dc_size(ct3d, &dc_mr);
>> +
>> +    if (!vmr && !pmr && !dc_mr) {
>
>That's a bit late given you used them to get the sizes.
>Do this before filling sizes.
>
ok
>> +        return -ENODEV;
>> +    }
>> +
>> +    if ((dpa_addr + length) > vmr_size + pmr_size + dc_size) {
>Skip inner brackets.
>
ok
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (dpa_addr > vmr_size + pmr_size) {
>> +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
>> +            return -ENODEV;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,
>> +                          uint8_t fill_value)
>> +{
>> +
>> +    MemoryRegion *vmr = NULL, *pmr = NULL;
>> +    uint64_t vmr_size = 0, pmr_size = 0;
>> +    AddressSpace *as = NULL;
>> +    MemTxAttrs mem_attrs = {0};
>> +
>> +    vmr_size = get_vmr_size(ct3d, &vmr);
>> +    pmr_size = get_pmr_size(ct3d, &pmr);
>> +
>> +    if (dpa_addr < vmr_size) {
>> +        as = &ct3d->hostvmem_as;
>> +    } else if (dpa_addr < vmr_size + pmr_size) {
>> +        as = &ct3d->hostpmem_as;
>> +    } else {
>> +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
>> +            return -ENODEV;
>> +        }
>> +        as = &ct3d->dc.host_dc_as;
>> +    }
>> +
>> +    return address_space_set(as, dpa_addr,
>> +                              fill_value, length, mem_attrs);
>
>Odd wrap.  Put as much as fits on line under 80 chars on first line
>then align next line to just after (
>
ok
>> +}
>> +
>> +/* Perform the actual device zeroing */
>> +static void __do_sanitize(CXLType3Dev *ct3d)
>> +{
>> +    struct CXLSanitizeInfo  *san_info = ct3d->media_op_sanitize;
>> +    int dpa_range_count = san_info->dpa_range_count;
>> +    int rc = 0;
>> +
>> +    for (int i = 0; i < dpa_range_count; i++) {
>
>Declare i outside loop (match local style).
>
ok
>> +        rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
>> +                san_info->dpa_range_list[i].length, san_info->fill_value);
>
>Either align 4 spaces after start of line above, or immediately after (
>
>> +        if (rc) {
>> +            goto exit;
>> +        }
>> +    }
>> +exit:
>> +    g_free(ct3d->media_op_sanitize);
>> +    ct3d->media_op_sanitize = NULL;
>> +    return;
>> +}
>> +
>>  enum {
>>      MEDIA_OP_CLASS_GENERAL  = 0x0,
>>          #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
>> @@ -1760,9 +1884,9 @@ static const struct media_op_supported_list_entry media_op_matrix[] = {
>>  };
>>
>>  static CXLRetCode media_operations_discovery(uint8_t *payload_in,
>> -                                                size_t len_in,
>> -                                                uint8_t *payload_out,
>> -                                                size_t *len_out)
>> +                                             size_t len_in,
>> +                                             uint8_t *payload_out,
>> +                                             size_t *len_out)
>
>Ah. Drag this to earlier patch.
>
ok
>>  {
>>      struct {
>>          uint8_t media_operation_class;
>> @@ -1811,6 +1935,66 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +static CXLRetCode media_operations_sanitize(CXLType3Dev *ct3d,
>> +                                            uint8_t *payload_in,
>> +                                            size_t len_in,
>> +                                            uint8_t *payload_out,
>> +                                            size_t *len_out,
>> +                                            uint8_t fill_value,
>> +                                            CXLCCI *cci)
>> +{
>> +    struct media_operations_sanitize {
>> +        uint8_t media_operation_class;
>> +        uint8_t media_operation_subclass;
>> +        uint8_t rsvd[2];
>> +        uint32_t dpa_range_count;
>> +        struct {
>> +            uint64_t starting_dpa;
>> +            uint64_t length;
>> +        } dpa_range_list[];
>> +    } QEMU_PACKED *media_op_in_sanitize_pl = (void *)payload_in;
>> +    uint32_t dpa_range_count = media_op_in_sanitize_pl->dpa_range_count;
>> +    uint64_t total_mem = 0;
>> +    int secs = 0;
>> +
>> +    if (len_in < (sizeof(*media_op_in_sanitize_pl) +
>> +           (dpa_range_count * sizeof(struct dpa_range_list_entry)))) {
>> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>> +    }
>> +
>> +    for (int i = 0; i < dpa_range_count; i++) {
>
>Declare outside of there (to match local style)
>
ok
>> +        if (validate_dpa_addr(ct3d,
>> +            media_op_in_sanitize_pl->dpa_range_list[i].starting_dpa,
>
>Hmm. This is tricky to read because of alignment.  I'd have local
>start_dpa nad length variables.
>
ok
>    for (i = 0; i < dpa_range_count; i++) {
>        uint64_t start_dpa = media_op_in_sanitize_pl->dpa_range_list[i].starting_dpa;
>        uint64_t length = media_op_in_sanitize_pl->dpa_range_list[i].length;
>
>	if (validate_dpa_addr(ct3d, dpa_start, length)) {
>
>> +            media_op_in_sanitize_pl->dpa_range_list[i].length)) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +        total_mem += media_op_in_sanitize_pl->dpa_range_list[i].length;
>> +    }
>> +    ct3d->media_op_sanitize = g_malloc0(sizeof(struct CXLSanitizeInfo) +
>> +                                  (dpa_range_count *
>> +                                  sizeof(struct dpa_range_list_entry)));
>> +
>> +    if (ct3d->media_op_sanitize) {
>> +        ct3d->media_op_sanitize->dpa_range_count = dpa_range_count;
>> +        ct3d->media_op_sanitize->fill_value = fill_value;
>> +        memcpy(ct3d->media_op_sanitize->dpa_range_list,
>> +                  media_op_in_sanitize_pl->dpa_range_list,
>> +                  (dpa_range_count *
>> +                  sizeof(struct dpa_range_list_entry)));
>> +        secs = get_sanitize_duration(total_mem >> 20);
>> +    }
>> +
>> +    /* EBUSY other bg cmds as of now */
>> +    cci->bg.runtime = secs * 1000UL;
>> +    *len_out = 0;
>> +    /*
>> +     * media op sanitize is targeted so no need to disable media or
>> +     * clear event logs
>> +     */
>> +    return CXL_MBOX_BG_STARTED;
>> +
>
>No blank line here.
>
ok
>> +}
>> +
>>  static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>>                                           uint8_t *payload_in,
>>                                           size_t len_in,
>> @@ -1825,6 +2009,9 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>>          uint32_t dpa_range_count;
>>      } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
>>
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +    uint8_t fill_value = 0;
>
>Maybe just put this value in directly into where it is used?
>
ok
>> +
>>      if (len_in < sizeof(*media_op_in_common_pl)) {
>>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>>      }
>> @@ -1851,15 +2038,29 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>>          return media_operations_discovery(payload_in, len_in, payload_out,
>>                                               len_out);
>>      case MEDIA_OP_CLASS_SANITIZE:
>> +        if (dpa_range_count == 0) {
>> +            return CXL_MBOX_SUCCESS;
>> +        }
>>          switch (media_op_subclass) {
>> +        case MEDIA_OP_SAN_SUBC_SANITIZE:
>> +            fill_value = 0xF;
>> +            return media_operations_sanitize(ct3d, payload_in, len_in,
>> +                                             payload_out, len_out, fill_value,
>> +                                             cci);
>> +            break;
>
>Can reach this break so remove it.
>
ok
>> +        case MEDIA_OP_SAN_SUBC_ZERO:
>> +            fill_value = 0;
>> +            return media_operations_sanitize(ct3d, payload_in, len_in,
>> +                                             payload_out, len_out, fill_value,
>> +                                             cci);
>> +            break;
>
>Can't reach this break either.
>
ok
>>          default:
>>              return CXL_MBOX_UNSUPPORTED;
>>          }
>> +        break;
>>      default:
>>          return CXL_MBOX_UNSUPPORTED;
>>      }
>> -
>> -    return CXL_MBOX_SUCCESS;
>
>This removal belongs in patch 1
>
>>  }
>
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index a64739be25..b391a293a8 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -581,6 +581,8 @@ typedef struct CXLSetFeatureInfo {
>>      size_t data_size;
>>  } CXLSetFeatureInfo;
>>
>> +struct CXLSanitizeInfo;
>> +
>>  struct CXLType3Dev {
>>      /* Private */
>>      PCIDevice parent_obj;
>> @@ -651,6 +653,8 @@ struct CXLType3Dev {
>>          uint8_t num_regions; /* 0-8 regions */
>>          CXLDCRegion regions[DCD_MAX_NUM_REGION];
>>      } dc;
>> +
>> +    struct CXLSanitizeInfo  *media_op_sanitize;
>
>Only one place before *
>
ok

>>  };
>>
>>  #define TYPE_CXL_TYPE3 "cxl-type3"
>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_629ef_
Content-Type: text/plain; charset="utf-8"


------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_629ef_--
