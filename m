Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1137A49D
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886396; cv=none; b=h6jy4htZJAIsnmvgtFebg3lx3mFDj0wBIIdGkvrzxGG9DIL/JyoJlpSkpwakmITnjslAbX8YT+Jn7M1FmXC9IWkjjNiq1Gp/b+idL21bgJkltQcCIadDSEV+QQ3DQnyG4qpJqCU4UXTq9OBjP2Or0pjZswNdb65JQgH2TobCUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886396; c=relaxed/simple;
	bh=u9kYk3az7KXRXLSuoaROWjpQ5AZ6uDFUP9iab4TbsSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggloX0ofMn7AFaarEyMc3/y2YgvbHfMrzAmD/a3eQzB9LylvH2Oo2fh/jpLX22rYy5C6yPPAdybOfqyUWfHN/6CXo/4mrucEAmrZHM9xRC0kfdLjH75EsTL6ZULviysuTEPGopuDPkb34snf9jqlcO1G1l/veHGa2mG49kYKslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwF0yvvp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwF0yvvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771886395; x=1803422395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u9kYk3az7KXRXLSuoaROWjpQ5AZ6uDFUP9iab4TbsSY=;
  b=IwF0yvvpbg1EUwmij/icT3PiPY+9NM+WtfiRiSr/u4JZInfMob+eaB3C
   7mnBVdRmknOAbIeGbwu5gdV56q0sdkzZt29dYdQGI6AIA/EO6GWxqmOr4
   86/oOyhjm6eWsd6495OhnzCTPgokf60koinPqK0i/ZFtjw89F2WqM5ZSo
   x4AkUXT4fSYo0Dev3HManSBEIfl2phCvpOxwgmTNPLcFpHbVlFNfHWo+f
   lxWfTuZziFxZiC8tsag9FCsfjSVXODvvQiktRNmDwjUD3TJZB6UhKa/aq
   CKkzBedLFu1PERlWmVYvzZo6fhspTXcWaCSEEQqzo8y1vvQ+ug0mlEm42
   A==;
X-CSE-ConnectionGUID: KBc9xwHvTOqGBNh5g0x71w==
X-CSE-MsgGUID: Sr60bscHQPS75iG9aus7gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84347963"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="84347963"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:39:54 -0800
X-CSE-ConnectionGUID: /xPcctDeTqWW0bZiOZejUg==
X-CSE-MsgGUID: 8fY+RGB3R76Mj4jbNwwvhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="220229929"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.227]) ([10.125.110.227])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:39:54 -0800
Message-ID: <80000b5d-a5c8-4a2f-8537-dba449af5e84@intel.com>
Date: Mon, 23 Feb 2026 15:39:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl/mbox: validate payload size before accessing
 contents in cxl_payload_from_user_allowed()
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org
References: <20260220001618.963490-1-dave@stgolabs.net>
 <20260220001618.963490-2-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260220001618.963490-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/19/26 5:16 PM, Davidlohr Bueso wrote:
> cxl_payload_from_user_allowed() casts and dereferences the input
> payload without first verifying its size. When a raw mailbox command
> is sent with an undersized payload (ie: 1 byte for CXL_MBOX_OP_CLEAR_LOG,
> which expects a 16-byte UUID), uuid_equal() reads past the allocated buffer,
> triggering a KASAN splat:
> 
> BUG: KASAN: slab-out-of-bounds in memcmp+0x176/0x1d0 lib/string.c:683
> Read of size 8 at addr ffff88810130f5c0 by task syz.1.62/2258
> 
> CPU: 2 UID: 0 PID: 2258 Comm: syz.1.62 Not tainted 6.19.0-dirty #3 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0xab/0xe0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xce/0x650 mm/kasan/report.c:482
>  kasan_report+0xce/0x100 mm/kasan/report.c:595
>  memcmp+0x176/0x1d0 lib/string.c:683
>  uuid_equal include/linux/uuid.h:73 [inline]
>  cxl_payload_from_user_allowed drivers/cxl/core/mbox.c:345 [inline]
>  cxl_mbox_cmd_ctor drivers/cxl/core/mbox.c:368 [inline]
>  cxl_validate_cmd_from_user drivers/cxl/core/mbox.c:522 [inline]
>  cxl_send_cmd+0x9c0/0xb50 drivers/cxl/core/mbox.c:643
>  __cxl_memdev_ioctl drivers/cxl/core/memdev.c:698 [inline]
>  cxl_memdev_ioctl+0x14f/0x190 drivers/cxl/core/memdev.c:713
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xa8/0x330 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fdaf331ba79
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdaf1d77038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fdaf3585fa0 RCX: 00007fdaf331ba79
> RDX: 00002000000001c0 RSI: 00000000c030ce02 RDI: 0000000000000003
> RBP: 00007fdaf33749df R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fdaf3586038 R14: 00007fdaf3585fa0 R15: 00007ffced2af768
>  </TASK>
> 
> Add 'in_size' parameter to cxl_payload_from_user_allowed() and validate
> the payload is large enough.
> 
> Fixes: 6179045ccc0c ("cxl/mbox: Block immediate mode in SET_PARTITION_INFO command")
> Fixes: 206f9fa9d555 ("cxl/mbox: Add Clear Log mailbox command")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Applied to cxl/fixes
37589c9804b8

> ---
>  drivers/cxl/core/mbox.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index fa6dd0c94656..e7a6452bf544 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -311,6 +311,7 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>   * cxl_payload_from_user_allowed() - Check contents of in_payload.
>   * @opcode: The mailbox command opcode.
>   * @payload_in: Pointer to the input payload passed in from user space.
> + * @in_size: Size of @payload_in in bytes.
>   *
>   * Return:
>   *  * true	- payload_in passes check for @opcode.
> @@ -325,12 +326,15 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>   *
>   * The specific checks are determined by the opcode.
>   */
> -static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
> +static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in,
> +					  size_t in_size)
>  {
>  	switch (opcode) {
>  	case CXL_MBOX_OP_SET_PARTITION_INFO: {
>  		struct cxl_mbox_set_partition_info *pi = payload_in;
>  
> +		if (in_size < sizeof(*pi))
> +			return false;
>  		if (pi->flags & CXL_SET_PARTITION_IMMEDIATE_FLAG)
>  			return false;
>  		break;
> @@ -338,6 +342,8 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
>  	case CXL_MBOX_OP_CLEAR_LOG: {
>  		const uuid_t *uuid = (uuid_t *)payload_in;
>  
> +		if (in_size < sizeof(uuid_t))
> +			return false;
>  		/*
>  		 * Restrict the ‘Clear log’ action to only apply to
>  		 * Vendor debug logs.
> @@ -365,7 +371,8 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
>  		if (IS_ERR(mbox_cmd->payload_in))
>  			return PTR_ERR(mbox_cmd->payload_in);
>  
> -		if (!cxl_payload_from_user_allowed(opcode, mbox_cmd->payload_in)) {
> +		if (!cxl_payload_from_user_allowed(opcode, mbox_cmd->payload_in,
> +						  in_size)) {
>  			dev_dbg(cxl_mbox->host, "%s: input payload not allowed\n",
>  				cxl_mem_opcode_to_name(opcode));
>  			kvfree(mbox_cmd->payload_in);

