Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F66381B0F;
	Tue, 23 Jun 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223812; cv=none; b=nyeUsd9G14cIxv9XDcwzqQXsIB6nt99KlRp30X0t4tw8v7rhN0niuw5MReqIDw7n0pcRgZomIvFmnADvEBoSoYTfX/WIZ64cQph3nY09FBVSzHO0e2zV0yxuGl7hHa5o+gv25P6m25BwFqhvVi13ejgTk7hjI6NxgouO2DSUM6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223812; c=relaxed/simple;
	bh=04LWBRt1fhPb6KOC1LKC35MWnwoOw6Cs+icm32HnrRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msh9aE34wlpV8nMIqb6KexcBCmaPEY/XRT4H2LHLl+492IjNW2TzbU+GABUN3p9N1VK2Be5xvONNPlTtNXpb8jlj3aa2BVwKUaNP7ByuHWRYcqPKBVgK5UKC2EPKGkVf60xlN+Zb4cDnP5M38MbQjsjIhrsAtxYMISSbDlrR7Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCVqNhBV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCVqNhBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782223810; x=1813759810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=04LWBRt1fhPb6KOC1LKC35MWnwoOw6Cs+icm32HnrRc=;
  b=QCVqNhBVaQ7N7aSIrerrBOleH4xGUZ7YuwepeeOvDW59GCnizuS/tMZo
   duNOVqP9gf39L15o40quMb6EyvWg1OzI/XrIt7X866c69nP0L7Uzvb4Sh
   IuISL0iLg0YQzqljGKykqY31bdtO3LckDfJ+nofc8CFWFqDHPtml09omb
   fHvsZDKK/3cIUvSWt+x2fzSN7sttZ04rnQ7St7wK0OYg8duesEEkHly6D
   wh+mlTf4KSl4LdLR2Wt3386GACdYn/OmUP1CTWWeHaL5TVPhA4Xv4pp4m
   uHoTt/knBKUaCPumZnJliNu6gsAK9GpAB9of5c2+DVqfcTL83gKRAFSug
   g==;
X-CSE-ConnectionGUID: 64bwR6oJTe+ciqGWsPKmug==
X-CSE-MsgGUID: w/fhXlUsQXqg2FqL61RvjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82074261"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82074261"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 07:10:09 -0700
X-CSE-ConnectionGUID: J1QHnrWpRe2+StEATMLn4Q==
X-CSE-MsgGUID: hPbt9iOxQkKuXZQdN2tIhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="254623210"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.151]) ([10.125.108.151])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 07:10:07 -0700
Message-ID: <b8dce325-3f16-444f-bed4-8c6df4f9333a@intel.com>
Date: Tue, 23 Jun 2026 07:10:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/features: Bound Get Feature read count to the output
 buffer
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, djbw@kernel.org, shiju.jose@huawei.com,
 ming.li@zohomail.com, alucerop@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260611094944.31638-1-icheng@nvidia.com>
 <e3450695-1182-43a7-ade8-2d056efbac0c@intel.com>
 <ajnm3jW3EO9SuCWr@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ajnm3jW3EO9SuCWr@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/26 6:54 PM, Richard Cheng wrote:
> On Thu, Jun 11, 2026 at 08:28:00AM +0800, Dave Jiang wrote:
>>
>>
>> On 6/11/26 2:49 AM, Richard Cheng wrote:
>>> cxlctl_get_feature() sizes the output buffer rpc_out from the
>>> user-controlled fwctl_rpc.out_len, but the number of bytes the device is
>>> asked to write into rpc_out->payload comes from a separate
>>> user-controlled filed, cxl_mbox_get_feat_in.count. Nothing ties them
>>> together, so a small out_len with a large count makes cxl_get_feature()
>>> write the device's feature data past the kvzalloc()'d buffer. A heap OOB
>>> write reachable from FWCTL_RPC. Reject requests where count exceeds the
>>> available payload room, before the allocation.
>>>
>>>
>>> The issue is triggered via the following reproducer [1], with error log
>>> [2].
>>>
>>> [1]:
>>> """
>>>         #include <fcntl.h>
>>>         #include <stdint.h>
>>>         #include <string.h>
>>>         #include <sys/ioctl.h>
>>>
>>>         #define FWCTL_RPC      _IO(0x9A, 1)
>>>         #define GET_SUP_FEATS  0x0500
>>>         #define GET_FEATURE    0x0501
>>>
>>>         struct fwctl_rpc { uint32_t size, scope, in_len, out_len; uint64_t in, o
>>>         struct hdr { uint32_t opcode, flags, op_size, rsvd; };               /*
>>>         struct get_feat_in { uint8_t uuid[16]; uint16_t off, count; uint8_t sel;
>>>                 __attribute__((packed));                                     /*
>>>         struct feat_entry { uint8_t uuid[16]; uint16_t id, get_sz, set_sz;
>>>                 uint32_t flags; uint8_t gv, sv; uint16_t eff; uint8_t rsvd[18];
>>>                 __attribute__((packed));                                     /*
>>>
>>>         static int fd;
>>>         static int rpc(uint32_t il, void *i, uint32_t ol, void *o) {
>>>                 struct fwctl_rpc r = { sizeof(r), 0, il, ol,
>>>                         (uint64_t)(uintptr_t)i, (uint64_t)(uintptr_t)o };
>>>                 return ioctl(fd, FWCTL_RPC, &r);
>>>         }
>>>
>>>         int main(void) {
>>>                 uint8_t in[48] = {0}, out[8192] = {0}, o8[8] = {0};
>>>                 struct hdr *h = (void *)in;
>>>                 fd = open("/dev/fwctl/fwctl0", O_RDWR);
>>>
>>>                 /* 1. enumerate features -> pick a real UUID with readable data
>>>                 h->opcode = GET_SUP_FEATS; h->op_size = 8;
>>>                 *(uint32_t *)(in + 16) = 48 * 64;          /* get_sup_feats_in.c
>>>                 rpc(48, in, sizeof(out), out);
>>>                 int n = *(uint16_t *)(out + 8);            /* num_entries */
>>>                 struct feat_entry *e = (void *)(out + 16);
>>>                 int b = 0;
>>>                 for (int k = 0; k < n; k++) if (e[k].get_sz > e[b].get_sz) b = k
>>>
>>>                 /* 2. Get Feature: out_len=8 (zero payload room) + non-zero coun
>>>                 memset(in, 0, sizeof(in));
>>>                 h->opcode = GET_FEATURE; h->op_size = 21;
>>>                 struct get_feat_in *g = (void *)(in + 16);
>>>                 memcpy(g->uuid, e[b].uuid, 16);
>>>                 g->count = e[b].get_sz < 32 ? e[b].get_sz : 32;
>>>                 return rpc(48, in, 8, o8);                 /* -> OOB write below
>>>         }
>>> """
>>>
>>> [2]:
>>> """
>>>   BUG: KASAN: slab-out-of-bounds in memcpy_fromio+0x234/0x730
>>>   Write of size 8 at addr ffff00016b629648 by task repro_fwctl_get/3637
>>>
>>>   CPU: 41 UID: 0 PID: 3637 Comm: repro_fwctl_get Not tainted
>>>   7.1.0-rc7-cxltest-kasan+ #1 PREEMPT(full)
>>>   Call trace:
>>>    show_stack+0x28/0x48 (C)
>>>    __dump_stack+0x2c/0x50
>>>    dump_stack_lvl+0x80/0xb8
>>>    print_address_description+0x84/0x220
>>>    print_report+0x54/0x80
>>>    kasan_report+0xb4/0x130
>>>    __asan_report_store_n_noabort+0x20/0x38
>>>    memcpy_fromio+0x234/0x730
>>>    cxl_pci_mbox_send+0x6c4/0xc00
>>>    cxl_internal_send_cmd+0x114/0x228
>>>    cxl_get_feature+0x18c/0x2a0
>>>    cxlctl_fw_rpc+0x5f0/0xeb8
>>>    fwctl_cmd_rpc+0x2c0/0x598
>>>    fwctl_fops_ioctl+0x30c/0x4a0
>>>    __arm64_sys_ioctl+0xc08/0x1380
>>>    invoke_syscall+0x110/0x188
>>>    do_el0_svc+0x110/0x1b0
>>>    el0_svc+0x48/0x108
>>>    el0t_64_sync_handler+0x88/0x148
>>>    el0t_64_sync+0x1b8/0x1c0
>>>
>>>   Allocated by task 3637:
>>>    kasan_save_track+0x44/0x98
>>>    kasan_save_alloc_info+0x48/0x70
>>>    __kasan_kmalloc+0xa0/0xd0
>>>    __kvmalloc_node_noprof+0x3fc/0x6a0
>>>    cxlctl_fw_rpc+0x5b8/0xeb8
>>>    fwctl_cmd_rpc+0x2c0/0x598
>>>    fwctl_fops_ioctl+0x30c/0x4a0
>>>    __arm64_sys_ioctl+0xc08/0x1380
>>>    invoke_syscall+0x110/0x188
>>>    do_el0_svc+0x110/0x1b0
>>>    el0_svc+0x48/0x108
>>>    el0t_64_sync_handler+0x88/0x148
>>>    el0t_64_sync+0x1b8/0x1c0
>>>
>>>   The buggy address belongs to the object at ffff00016b629640
>>>    which belongs to the cache kmalloc-rnd-04-8 of size 8
>>>   The buggy address is located 0 bytes to the right of
>>>    allocated 8-byte region [ffff00016b629640, ffff00016b629648)
>>>
>>>   The buggy address belongs to the physical page:
>>>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eb62
>>>   flags: 0x17fffc000000000(node=0|zone=2|lastcpupid=0x1ffff)
>>>   page_type: f5(slab)
>>>   raw: 017fffc000000000 ffff000080016c00 dead000000000100 dead000000000122
>>>   raw: 0000000000000000 0000000808000800 00000000f5000000 0000000000000000
>>>   page dumped because: kasan: bad access detected
>>>
>>>   Memory state around the buggy address:
>>>    ffff00016b629500: fa fc fc fc fa fc fc fc fa fc fc fc 00 fc fc fc
>>>    ffff00016b629580: fa fc fc fc fa fc fc fc fc fc fc fc fa fc fc fc
>>>   >ffff00016b629600: fa fc fc fc fa fc fc fc 00 fc fc fc fa fc fc fc
>>>                                                 ^
>>>    ffff00016b629680: fa fc fc fc fa fc fc fc fc fc fc fc fa fc fc fc
>>>    ffff00016b629700: 00 fc fc fc fc fc fc fc fa fc fc fc fc fc fc fc
>>>   ==================================================================
>>> """
>>>
>>> Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
>>> Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
>>> Reviewed-by: Koba Ko <kobak@nvidia.com>
>>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>> The oops log can probably be trimmed. And the reproducer isn't necessary in the commit log.
>>
>> However, can the reproducer be add to CXL CLI unit test?
>>
> 
> Hi Dave,
> 
> I want to make sure you want it as a in-tree unit test
> or you want a follow up ndctl patch which can cooperate with
> cxl_test ?
> 
> I suppose the latter will fit better ?

Follow up ndctl patch please. Thanks!

> 
> Best regards,
> Richard Cheng.
>  
>>
>>> ---
>>>  drivers/cxl/core/features.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>>> index 3435db9ea6b1..3f949225da6d 100644
>>> --- a/drivers/cxl/core/features.c
>>> +++ b/drivers/cxl/core/features.c
>>> @@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
>>>  	if (!count)
>>>  		return ERR_PTR(-EINVAL);
>>>  
>>> +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
>>> +	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>>  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
>>>  		kvzalloc(out_size, GFP_KERNEL);
>>>  	if (!rpc_out)
>>>
>>> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
>>

