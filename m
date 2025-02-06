Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E29214209
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842567; cv=none; b=hfxXZbzFybqnDLGFNbQXvsWs2oGCOk6huEQwUUidBSRBvfOhz1ezEM00F++MmxU5liYK8Y/TH2rRoy2rMLtD3SR3KaWH2SKNF+PFMsfJvJPuuO0e7/1vDrxAi/v5z7VIIuVdK/GYcN1CQjCSiqPrJ21FtXfATNPQWCvq/bpjpIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842567; c=relaxed/simple;
	bh=gc2HFXzyqzHZc7GTJd20HAAs9igyba2WdXCoIt/zJ2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=VkCNEDiVdkr75iLycZXENqn3S9/aoHIDAsmGO97zM2mz5Wf0pJWLGtulPMEP2PsmtGZd/e7vcp9xgupdE1+CIDfBvUySr+BQt3nCBIbK9imGNdd9k6v04GSYH0VzT+/Mn3M4SBK2QnwShvgkcRhmP53nzxPd4OnkmWMVAWjUKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uHyT8Syk; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uHyT8Syk"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250206114920epoutp0293bd4d00e544a1e90388b638cd74c686~hnBiHnXE70562105621epoutp025
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 11:49:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250206114920epoutp0293bd4d00e544a1e90388b638cd74c686~hnBiHnXE70562105621epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738842560;
	bh=8BO6fSJ3PLRi0PMbkALdhPzyPL/cIx2ZMkox75hjJVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uHyT8SykdZeXmjj4U3cou4cnZbK5oKsGWL72y1R/nrzdrwVWH4FZ6mq5qOj7w8Ap6
	 OGR/lAs45o7WS7Jb8K1m8HzU/9fu9GSoFsYxwS9nR9BupfL3OI53auSmboSqBZ2FXV
	 cI+uvfQPBkkWTQNhBgo5HjKQ1XiVCm22iAaWlpkA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250206114920epcas5p46a9d6f7601ef839f81fae1057c86ae57~hnBh1mL_n1700217002epcas5p4l;
	Thu,  6 Feb 2025 11:49:20 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Ypb3y1qlkz4x9Pv; Thu,  6 Feb
	2025 11:49:18 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.42.29212.EB1A4A76; Thu,  6 Feb 2025 20:49:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250206092733epcas5p3d5435304fce10ca2eafaf10c0a8ec295~hlFvKIBvN2615426154epcas5p3B;
	Thu,  6 Feb 2025 09:27:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250206092733epsmtrp197232591cf83ac86a46ec1877ab13873~hlFvGXg_r2070520705epsmtrp1e;
	Thu,  6 Feb 2025 09:27:33 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-7a-67a4a1be7f21
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.3E.18729.48084A76; Thu,  6 Feb 2025 18:27:32 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250206092731epsmtip2c17e43ee75922a89f81fd147cf80b8e6~hlFt25wvA2968629686epsmtip2C;
	Thu,  6 Feb 2025 09:27:31 +0000 (GMT)
Date: Thu, 6 Feb 2025 14:57:24 +0530
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, krish.reddy@samsung.com, vishak.g@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, s5.kumari@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Message-ID: <20250206092714.zdwd6lddw64d5j3b@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250124151946.0000134f@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTS3ffwiXpBou3cFhMP6xo8eX0HjaL
	VQuvsVks3LiMyeL8rFMsFsd7d7BYrDn3mQXIncPuwOHRcuQtq8eTa5uZPPq2rGL0+LxJLoAl
	KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gKJYWy
	xJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2
	xtcz09gKJhdXTN7ylqWBcX1QFyMHh4SAicTfOaVdjFwcQgJ7GCV+zDrBDuF8YpS4cvkvM4Tz
	jVHi8K4ZQBlOsI4nuy6zQCT2MkqsOnqLDa5l58eLbCBVLAIqEi/W9LKC2GwCBhIPmo+DdYsI
	GEm8uzGJEaSBWWATUEPTQ7AGYYFWRokPq/JBbF4BZ4nPG+exQtiCEidnPmEBsTkFDCUOzlgA
	tlpC4CO7xI99U9ghvnCROL3MH+I8YYlXx7dAnSol8bK/Dcouljh38RMjhF0j8bprBTOEbS/R
	eqofzGYWyJD4t+0wVL2sxNRT65gg4nwSvb+fMEHEeSV2zAOxQdaqSCx9mwmz6suzZqjxHhJz
	9q6DhuMLRokFU/exTWCUm4XknVlI1kHYVhKdH5pYZwGNZRaQllj+jwPC1JRYv0t/ASPrKkap
	1ILi3PTUZNMCQ9281HJ4LCfn525iBKdMrYAdjKs3/NU7xMjEwXiIUYKDWUmE9/T2BelCvCmJ
	lVWpRfnxRaU5qcWHGE2BETSRWUo0OR+YtPNK4g1NLA1MzMzMTCyNzQyVxHmbd7akCwmkJ5ak
	ZqemFqQWwfQxcXBKNTDFfpyytuH35KJdCp3CNZs99LTXlMpNjzm+5QB/6l2nyXrxz8QTAmqb
	IpQ7khRnfOKT62yakKxW+2mzbEtY9n7VqcEyd4/Wtp95k3tmZYWgsfiMHaxStUxuPiVRyzN7
	H5TXap16un9BQ2J4tF+1/91PE92FvXcptZsK1h8x+ZtSWmZwT/NY74dcmRM7C//vvenQl97x
	9V8Do5pJs+0yJrPO209+pR+59Fmk5kf8wsZIiZa8wmezDT8vN16+uJRlr6bS3tqqntP9e7Zl
	5xZ2Pvg1py/tZdc1teDSzya35DZci2w2mucn9byKI+wU+/I0gVOTAz5cyvnFx+jtl/P5qPbk
	lyt8Vm/NfbH6Ye7jaCWW4oxEQy3mouJEAAxpijYiBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvG5Lw5J0g80bLSymH1a0+HJ6D5vF
	qoXX2CwWblzGZHF+1ikWi+O9O1gs1pz7zALkzmF34PBoOfKW1ePJtc1MHn1bVjF6fN4kF8AS
	xWWTkpqTWZZapG+XwJVxY/l99oKjBRVve+6yNzD+9u9i5OSQEDCReLLrMksXIxeHkMBuRon5
	L/ezQySkJI7t/MkGYQtLrPz3HCwuJPCBUeLDNRMQm0VAReLFml5WEJtNwEDiQfNxsBoRASOJ
	dzcmMYIMZRbYxChx5OZsZpCEsEArUPOqfBCbV8BZ4vPGeawQm18wSkw/tZ8FIiEocXLmEzCb
	WcBMYt7mh0DNHEC2tMTyfxwgYU4BQ4mDMxawTGAUmIWkYxaSjlkIHQsYmVcxSqYWFOem5xYb
	FhjmpZbrFSfmFpfmpesl5+duYgSHupbmDsbtqz7oHWJk4mA8xCjBwawkwnt6+4J0Id6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4rziL3pThATSE0tSs1NTC1KLYLJMHJxSDUwV2aslVixYGDG3v+rq
	priohMjqUyzbdjo1frPgnPd7eY7X2/eyPuWy65eWTJnEF3D9iddzF79pO4o3sxkd3fPf8fIz
	I21Lj5Ufz2mq1XBya66U6p6/4YZEQ/6lb1cr+4+zPLTgSwi6dOHC9Bf7Y1nWVxV9XP7uQ9WC
	XmZlixehtxc0ey5Rao0I/xOdF3XvVMLeJbdkqhY3vbyUt77183JrBaalcW563m3Ljr41cH6z
	7oihzvqt/JMm/P8ftSJZpK0tpPjRzsmdV7QFHLew7D5yuGTeQe1dbfXr701L5fzK9F7FlHFn
	2dZH7TaH65LbNXiVYm6Lq9o+bGZwOnyjzGvrqozKh+qHt9nOen3nOtcnJZbijERDLeai4kQA
	GxVvyOQCAAA=
X-CMS-MailID: 20250206092733epcas5p3d5435304fce10ca2eafaf10c0a8ec295
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_32b8a_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
	<CGME20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2@epcas5p4.samsung.com>
	<20250123050903.92336-3-vinayak.kh@samsung.com>
	<20250124151946.0000134f@huawei.com>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_32b8a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 24/01/25 03:19PM, Jonathan Cameron wrote:
>On Thu, 23 Jan 2025 10:39:03 +0530
>Vinayak Holikatti <vinayak.kh@samsung.com> wrote:
>
>>     CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.
>>     CXL devices supports media operations Sanitize and Write zero command.
>
>As before, don't indent this.
>
>>
>> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c  | 217 ++++++++++++++++++++++++++++++++++--
>>  include/hw/cxl/cxl_device.h |  11 ++
>>  2 files changed, 220 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 2315d07fb1..89847ddd9d 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -1722,6 +1722,145 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_BG_STARTED;
>>  }
>>
>> +#define DPA_RANGE_GRANULARITY 64
>
>Could use existing CXL_CACHELINE_SIZE definition for this, though I guess
>strictly speaking it could be unrelated.
>
>> +struct dpa_range_list_entry {
>> +    uint64_t starting_dpa;
>> +    uint64_t length;
>> +};
>> +
>> +static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
>> +                             size_t length)
>> +{
>> +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
>> +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
>> +    int rc = 0;
>> +
>> +    if ((dpa_addr % DPA_RANGE_GRANULARITY) ||
>> +         (length % DPA_RANGE_GRANULARITY)) {
>Probably makes sense to also check for length 0 here as that would
>be very odd if sent.
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (ct3d->hostvmem) {
>> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
>> +        vmr_size = memory_region_size(vmr);
>> +    }
>> +    if (ct3d->hostpmem) {
>> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
>> +        pmr_size = memory_region_size(pmr);
>> +    }
>> +    if (ct3d->dc.host_dc) {
>> +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
>> +        dc_size = memory_region_size(dc_mr);
>> +    }
>> +
>> +    if (!vmr && !pmr && !dc_mr) {
>> +        return -ENODEV;
>> +    }
>> +
>> +    if (dpa_addr >= vmr_size + pmr_size + dc_size ||
>> +        (dpa_addr + length) > vmr_size + pmr_size + dc_size) {
>
>If length is checked as non zero above, only the second test is needed.
>
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (dpa_addr > vmr_size + pmr_size) {
>> +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
>> +            return -ENODEV;
>> +        }
>> +    }
>> +
>> +
>> +    return rc;
>
>return 0. rc is never set to anything else.
>
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
>> +    if (ct3d->hostvmem) {
>> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
>> +        vmr_size = memory_region_size(vmr);
>> +    }
>> +    if (ct3d->hostpmem) {
>> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
>> +        pmr_size = memory_region_size(pmr);
>> +    }
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
>
>You could factor out everything down to here and then use that
>for the validate_dpa_addr() as finding an address space means
>we also checked the address is valid. Otherwise it does not match.

Didnt get what you meant, validate_dpa_addr is meant for 
checking valid dpa address and sanitize_range is 
get the address space handle to do actual sanitize
of dpa address, so two are different purposes, 

>
>> +
>> +    return  address_space_set(as, dpa_addr,
>
>odd spacing after return. Should just be one space.
>
>> +                              fill_value, length, mem_attrs);
>> +}
>> +
>> +/* Perform the actual device zeroing */
>> +static void __do_sanitize(CXLType3Dev *ct3d)
>> +{
>> +    struct CXLSanitizeInfo  *san_info = ct3d->media_op_sanitize;
>
>Single space only before *san_info
>
>> +    int dpa_range_count = san_info->dpa_range_count;
>> +    int rc = 0;
>> +
>> +    for (int i = 0; i < dpa_range_count; i++) {
>> +        rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
>> +                san_info->dpa_range_list[i].length, san_info->fill_value);
>> +        if (rc) {
>> +            goto exit;
>> +        }
>> +    }
>> +    cxl_discard_all_event_records(&ct3d->cxl_dstate);
>
>Add a comment on why we are deleting event records when sanitizing a small
>part of memory?
>
>> +exit:
>> +    g_free(ct3d->media_op_sanitize);
>> +    ct3d->media_op_sanitize = NULL;
>> +    return;
>> +}
>> +
>> +static int get_sanitize_duration(uint64_t total_mem)
>
>Where did this come from?  Factor out the existing code
>in cmd_santize_overwrite() instead of duplicating this stack
>of if/else if
>
>Ideally do that as a precursor patch as it's just code movement.
>
>
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
>>  enum {
>>      MEDIA_OP_GENERAL  = 0x0,
>>      MEDIA_OP_SANITIZE = 0x1,
>> @@ -1729,10 +1868,9 @@ enum {
>>  } MEDIA_OPERATION_CLASS;
>>
>>  enum {
>> -    MEDIA_OP_SUB_DISCOVERY = 0x0,
>> -    MEDIA_OP_SUB_SANITIZE = 0x0,
>> -    MEDIA_OP_SUB_ZERO     = 0x1,
>> -    MEDIA_OP_SUB_CLASS_MAX
>> +    MEDIA_OP_GEN_DISCOVERY = 0x0,
>> +    MEDIA_OP_SAN_SANITIZE = 0x0,
>> +    MEDIA_OP_SAN_ZERO     = 0x1,
>
>See naming suggestions in first patch. Make sure to tidy up so you don't introduce
>them there then change them here!
>
>>  } MEDIA_OPERATION_SUB_CLASS;
>>
>>  struct media_op_supported_list_entry {
>> @@ -1777,9 +1915,14 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>>      };
>>      } QEMU_PACKED *media_op_in_pl = (void *)payload_in;
>>
>> +
>
>Blank line here doesn't add anything.
>
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>>      uint8_t media_op_cl = media_op_in_pl->media_operation_class;
>>      uint8_t media_op_subclass = media_op_in_pl->media_operation_subclass;
>>      uint32_t dpa_range_count = media_op_in_pl->dpa_range_count;
>> +    uint8_t fill_value = 0;
>> +    uint64_t total_mem = 0;
>> +    int secs = 0;
>>
>>      if (len_in < sizeof(*media_op_in_pl)) {
>>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>> @@ -1788,7 +1931,7 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>>      switch (media_op_cl) {
>>      case MEDIA_OP_GENERAL:
>>          switch (media_op_subclass) {
>> -        case MEDIA_OP_SUB_DISCOVERY:
>> +        case MEDIA_OP_GEN_DISCOVERY:
>>              int count = 0;
>>              struct media_op_discovery_out_pl *media_out_pl =
>>                  (void *)payload_out;
>> @@ -1806,7 +1949,7 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>>                  return CXL_MBOX_INVALID_INPUT;
>>              }
>>
>> -            media_out_pl->dpa_range_granularity = CXL_CAPACITY_MULTIPLIER;
>> +            media_out_pl->dpa_range_granularity = DPA_RANGE_GRANULARITY;
>>              media_out_pl->total_supported_operations = MAX_SUPPORTED_OPS;
>>              if (num_ops > 0) {
>>                  for (int i = start_index; i < MAX_SUPPORTED_OPS; i++) {
>> @@ -1824,22 +1967,73 @@ disc_out:
>>              media_out_pl->num_of_supported_operations = count;
>>              *len_out = sizeof(struct media_op_discovery_out_pl) +
>>              (sizeof(struct media_op_supported_list_entry) * count);
>> -            break;
>> +            goto exit;
>return CXL_MBOX_SUCCESS;  No purpose in having the exit label as nothing
>to be done.
>
>
>>          default:
>>              return CXL_MBOX_UNSUPPORTED;
>>          }
>>          break;
>>      case MEDIA_OP_SANITIZE:
>> +    {
>
>From code here not obvious why scoping {} needed.
>
>>          switch (media_op_subclass) {
>> -
>> +        case MEDIA_OP_SAN_SANITIZE:
>> +            if (len_in < (sizeof(*media_op_in_pl) +
>> +                   (dpa_range_count * sizeof(struct dpa_range_list_entry)))) {
>> +                return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>> +            }
>The check applies to all current cases. So move it outside this switch statement
>to remove duplication.  Here all you should do is set the fill_value;
>
>> +            fill_value = 0xF;
>> +            goto sanitize_range;
>> +        case MEDIA_OP_SAN_ZERO:
>> +            if (len_in < (sizeof(*media_op_in_pl) +
>> +                (dpa_range_count * sizeof(struct dpa_range_list_entry)))) {
>> +                return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>> +            }
>> +            fill_value = 0;
>> +            goto sanitize_range;
>Why goto. Just break...
>>          default:
>>              return CXL_MBOX_UNSUPPORTED;
>>          }
>and have the stuff below under the sanitize_range label here.
>
>>          break;
>> +    }
>>      default:
>>          return CXL_MBOX_UNSUPPORTED;
>>      }
>>
>> +sanitize_range:
>> +    if (dpa_range_count > 0) {
>> +        for (int i = 0; i < dpa_range_count; i++) {
>> +            if (validate_dpa_addr(ct3d,
>> +                media_op_in_pl->dpa_range_list[i].starting_dpa,
>> +                media_op_in_pl->dpa_range_list[i].length)) {
>> +                return CXL_MBOX_INVALID_INPUT;
>> +            }
>> +            total_mem += media_op_in_pl->dpa_range_list[i].length;
>> +        }
>> +        ct3d->media_op_sanitize = g_malloc0(sizeof(struct CXLSanitizeInfo) +
>> +                                  (dpa_range_count *
>> +                                  sizeof(struct dpa_range_list_entry)));
>> +
>> +        if (ct3d->media_op_sanitize) {
>> +            ct3d->media_op_sanitize->dpa_range_count = dpa_range_count;
>> +            ct3d->media_op_sanitize->fill_value = fill_value;
>> +            memcpy(ct3d->media_op_sanitize->dpa_range_list,
>> +                   media_op_in_pl->dpa_range_list,
>> +                   (dpa_range_count *
>> +                   sizeof(struct dpa_range_list_entry)));
>> +            secs = get_sanitize_duration(total_mem >> 20);
>> +            goto start_bg;
>> +        }
>> +    } else if (dpa_range_count == 0) {
>> +        goto exit;
>    if (dpa_range_count == 0) {
>       return CXL_MBOX_SUCCESS;
>    }
>    for (i = 0; i < dpa_range_count; i++)
>
>//that is return early in the simple case the no need for else
>and the extra level of indent on these long lines.
>
>
>> +    }
>> +
>> +start_bg:
>> +    /* EBUSY other bg cmds as of now */
>> +    cci->bg.runtime = secs * 1000UL;
>> +    *len_out = 0;
>> +    /* sanitize when done */
>> +    cxl_dev_disable_media(&ct3d->cxl_dstate);
>Why?  This is santizing part of the device. As I undestand it the
>main aim is to offload cleanup when the device is in use. Definitely
>don't want to disable media.  If I'm missing a reason please give
>a spec reference.
>
>> +    return CXL_MBOX_BG_STARTED;
>> +exit:
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> @@ -3154,6 +3348,13 @@ static void bg_timercb(void *opaque)
>>              cxl_dev_enable_media(&ct3d->cxl_dstate);
>>          }
>>          break;
>> +        case 0x4402: /* Media Operations sanitize */
>> +        {
>> +            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +            __do_sanitize(ct3d);
>> +            cxl_dev_enable_media(&ct3d->cxl_dstate);
>Ah. You turn it back on here.   Specification reference needed.
>> +        }
>> +        break;
>>          case 0x4304: /* scan media */
>>          {
>>              CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index a64739be25..6d82eb266a 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -581,6 +581,15 @@ typedef struct CXLSetFeatureInfo {
>>      size_t data_size;
>>  } CXLSetFeatureInfo;
>>
>> +struct CXLSanitizeInfo {
>> +    uint32_t dpa_range_count;
>> +    uint8_t fill_value;
>> +    struct {
>> +            uint64_t starting_dpa;
>> +            uint64_t length;
>> +    } dpa_range_list[0];
>[]
>> +};
>> +
>>  struct CXLType3Dev {
>>      /* Private */
>>      PCIDevice parent_obj;
>> @@ -651,6 +660,8 @@ struct CXLType3Dev {
>>          uint8_t num_regions; /* 0-8 regions */
>>          CXLDCRegion regions[DCD_MAX_NUM_REGION];
>>      } dc;
>> +
>> +    struct CXLSanitizeInfo  *media_op_sanitize;
>Here we just need to know there is a definition of struct
>CXLSantizeInfo not what form it takes.  So use a forwards
>defintion and push the definition of struct CXLSanitizeInfo
>down to where it is needed only (in the c file).
>
>Thanks,
>
>Jonathan
>
>>  };
>>
>>  #define TYPE_CXL_TYPE3 "cxl-type3"
>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_32b8a_
Content-Type: text/plain; charset="utf-8"


------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_32b8a_--
