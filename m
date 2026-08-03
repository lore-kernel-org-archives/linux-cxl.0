Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713FA2F7445;
	Mon,  3 Aug 2026 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780209; cv=none; b=tkm5jbKH9YdH1ZIq9ve/foO0c7zqAMSmvioDe1IsFJfh0z/AZ2J/ns7W+Mrh8ndve/mEBB2R939ZkgMvYWdEnvEnPRkmqP+B79WswlnzOde8ytw7+rBNP98g6wPN4arJ/cPdieGa+cIlZI+D/06Ob2/ItRdkGryKkf/e76fFHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780209; c=relaxed/simple;
	bh=TGoNR3HXz8zM7wPXiETNUAd3dU/dkStTzg9hxy5RUFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ip1GBi8AqOqCYKohbO1+BAh5m+JL+HFTzFPLJs0J1V1m+3tCmian4aprbGk25LO3LF9+ARbrVTZJe62GefG7+8oPpgcdq4mvc5acBtKAp7fLWRhixrLSIDpKbRoZ2S7NOZOc+dV+Hg+rrn0IHP1M8qF0D8XNALKaB1CQm0WR9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7h4hdop; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7h4hdop"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785780208; x=1817316208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TGoNR3HXz8zM7wPXiETNUAd3dU/dkStTzg9hxy5RUFw=;
  b=a7h4hdopLAR3NrY8SgPIRTAbH/Mb508uFazokFurSK5gJ2wEl+7pAjf2
   amXEAYKrM8LXdCuIghpxuDdtGIus8g+amJYZkjRRpIgpE0NwQPI+UgdT5
   YSowShlnxB2Y8j1X/eS5nz2+vo53utAwTfol8Vfrj8BLaUcpFjOPNQqBy
   l0dSfs1Oez3gMVe5LSxB9+6HAfzMEhG3x6Gqb8WMT9ZXCTsyhhy62Hgak
   +HOOT78ug5DbnBHHqU2CE4h7JTjog99bDOAlXLTsIx1mHzMBTQx885No0
   HtYW1iky3jh4phif5eUJL5aUimOTX7WG3TukpzGHZPiFYha8JrD+Ok6Hy
   Q==;
X-CSE-ConnectionGUID: 9hbPp3zxQFiD82AsXvPD7g==
X-CSE-MsgGUID: 40Us0iaKQsCbViqL+6iaqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="85301109"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="85301109"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 11:03:27 -0700
X-CSE-ConnectionGUID: bvPtUuIrTaW08GIIo93z8Q==
X-CSE-MsgGUID: 3nD+Z1FJSGCspWyysoSRTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="299505437"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.108.187]) ([10.125.108.187])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 11:03:25 -0700
Message-ID: <9b3a1271-642f-442d-b545-d00d6863a54c@intel.com>
Date: Mon, 3 Aug 2026 11:03:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/8] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
To: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Fan Ni <nifan.cxl@gmail.com>,
 Li Ming <ming.li@zohomail.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>,
 Heesoo Kim <habil.kim@samsung.com>, Anisa Su <anisa.su@samsung.com>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
 <20260731084901.1512819-2-anisa.su@samsung.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260731084901.1512819-2-anisa.su@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/31/26 1:48 AM, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Per the CXL 4.0 specification software must check the Command Effects
> Log (CEL) for dynamic capacity command support.
> 
> Detect support for the DCD commands while reading the CEL, including:
> 
>         Get DC Config
>         Get DC Extent List
>         Add DC Response
>         Release DC
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> 
> ---
> Changes:
> 1. mbox.c: leave mds->dcd_supported false so the hardware enablement
>    patches can be upstreamed ahead of the extent and DAX work; the
>    event handling patch re-enables it.
> ---
>  drivers/cxl/core/mbox.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 20 +++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..4790524c32a7 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -165,6 +165,38 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
>  	}
>  }
>  
> +static bool cxl_is_dcd_command(u16 opcode)
> +{
> +#define CXL_MBOX_OP_DCD_CMDS 0x48
> +
> +	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
> +}
> +
> +static void cxl_set_dcd_cmd_enabled(u16 opcode, unsigned long *cmd_mask)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_DC_CONFIG:
> +		set_bit(CXL_DCD_ENABLED_GET_CONFIG, cmd_mask);
> +		break;
> +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> +		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, cmd_mask);
> +		break;
> +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> +		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, cmd_mask);
> +		break;
> +	case CXL_MBOX_OP_RELEASE_DC:
> +		set_bit(CXL_DCD_ENABLED_RELEASE, cmd_mask);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static bool cxl_verify_dcd_cmds(unsigned long *cmds_seen)
> +{
> +	return bitmap_full(cmds_seen, CXL_DCD_ENABLED_MAX);
> +}
> +
>  static bool cxl_is_poison_command(u16 opcode)
>  {
>  #define CXL_MBOX_OP_POISON_CMDS 0x43
> @@ -757,6 +789,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_cel_entry *cel_entry;
>  	const int cel_entries = size / sizeof(*cel_entry);
> +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX) = {};
>  	struct device *dev = mds->cxlds.dev;
>  	int i, ro_cmds = 0, wr_cmds = 0;
>  
> @@ -785,11 +818,22 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  			enabled++;
>  		}
>  
> +		if (cxl_is_dcd_command(opcode)) {
> +			cxl_set_dcd_cmd_enabled(opcode, dcd_cmds);
> +			enabled++;
> +		}
> +
>  		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
>  			enabled ? "enabled" : "unsupported by driver");
>  	}
>  
>  	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
> +	/*
> +	 * Disabled until event handling implemented.
> +	 */
> +	if (cxl_verify_dcd_cmds(dcd_cmds))
> +		dev_dbg(dev, "Device supports DCD; capability disabled\n");
> +	mds->dcd_supported = false;

Assume this is intentional to disable DCD for the prep series. Should mention that in the commit log as something to come back to and change later. Also prevent sashiko from tripping on that. With the note:

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

DJ


>  }
>  
>  static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ed419d0c59f2..616eeaeee5b9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -252,6 +252,20 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>  
> +/**
> + * CXL r4.0 Section 8.2.10.9 - Memory Device Command Sets. See Table 8-308.
> + *
> + * The 48h Command Set (Opcodes 4800h - 4803h) defines the device-enabled DCD
> + * commands.
> + */
> +enum dcd_cmd_enabled_bits {
> +	CXL_DCD_ENABLED_GET_CONFIG,
> +	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> +	CXL_DCD_ENABLED_ADD_RESPONSE,
> +	CXL_DCD_ENABLED_RELEASE,
> +	CXL_DCD_ENABLED_MAX
> +};
> +
>  /* Device enabled poison commands */
>  enum poison_cmd_enabled_bits {
>  	CXL_POISON_ENABLED_LIST,
> @@ -427,6 +441,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @partition_align_bytes: alignment size for partition-able capacity
>   * @active_volatile_bytes: sum of hard + soft volatile
>   * @active_persistent_bytes: sum of hard + soft persistent
> + * @dcd_supported: all DCD commands are supported
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -446,6 +461,7 @@ struct cxl_memdev_state {
>  	u64 partition_align_bytes;
>  	u64 active_volatile_bytes;
>  	u64 active_persistent_bytes;
> +	bool dcd_supported;
>  
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> @@ -507,6 +523,10 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_UNLOCK		= 0x4503,
>  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> +	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
> +	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
> +	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
> +	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  

