Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3D25394A
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688201; cv=none; b=nyMiOODRLho9J4nIY+JZpM9B55Km4LXUb7qvdCPbMBPx559ag0GwIyKWaMNZGI//v1C0WU9D/gQqYfbIr3j/FO5uv+qA16Fa8cbpuBuTPPVnZAWtz7jnERkmY3CODCFx22TTmj94AoK5av3WbEawfjHaorAz+ujTb9bRIb/H4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688201; c=relaxed/simple;
	bh=JVgMz+Hn5ctS/fKDa6h6ByVBuI8CAIYiLcL5j6oLpWw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o26wtmh0gk6qOtAOePbpcSFS9b5iLOjHKtj0jslE+sCxtaPzHEAzekVi06H4AyUg+qMo0AbBVUc0bq8uXUxjKuvOrt9UZyGbJr7vGwChbLaQzEJmFDS2d4KjU609Lr5FVELYnnsZNVlIgdndf1efIKk3uAqVr01dq4feDolI1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQqky1NM0z6DJTH;
	Mon, 23 Jun 2025 22:11:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 82F2B140427;
	Mon, 23 Jun 2025 22:16:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 16:16:33 +0200
Date: Mon, 23 Jun 2025 15:16:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <jgroves@micron.com>, <ravis.opensrc@micron.com>,
	<fan.ni@samsung.com>, <anisa.su@samsung.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/7] cxl/mbox: Track background commands from CEL
Message-ID: <20250623151632.000070d4@huawei.com>
In-Reply-To: <20250617193611.564668-2-dave@stgolabs.net>
References: <20250617193611.564668-1-dave@stgolabs.net>
	<20250617193611.564668-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 17 Jun 2025 12:36:05 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Remember whether or not a command is background-capable, per the CEL.
> This will later be used to consult the bitmap to evaluate incoming
> mbox commands.
> 
> Further, "enable" any background commands that didn't fall in the
> uapi, poison or security categories, such as fw related. This prevents
> situations where the command is incorrectly listed as unsupported by
> the driver.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c | 30 ++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 28 ++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2689e6453c5a..4ea02f7a5b6b 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -202,6 +202,31 @@ static void cxl_set_poison_cmd_enabled(struct cxl_poison_state *poison,
>  	}
>  }
>  
> +static bool cxl_set_bgcmd_enabled(struct cxl_background_state *bg, u16 opcode)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_TRANSFER_FW:
> +		set_bit(CXL_BG_ENABLED_TRANSFER_FW, bg->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_ACTIVATE_FW:
> +		set_bit(CXL_BG_ENABLED_ACTIVATE_FW, bg->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_DO_MAINTENANCE:
> +		set_bit(CXL_BG_ENABLED_DO_MAINTENANCE, bg->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_SCAN_MEDIA:
> +		set_bit(CXL_BG_ENABLED_SCAN_MEDIA, bg->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_SANITIZE:
> +		set_bit(CXL_BG_ENABLED_SANITIZE, bg->enabled_cmds);
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
>  {
>  	struct cxl_mem_command *c;
> @@ -757,6 +782,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  
>  	for (i = 0; i < cel_entries; i++) {
>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
> +		u16 effect = le16_to_cpu(cel_entry[i].effect);
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  		int enabled = 0;
>  
> @@ -778,6 +804,10 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  			enabled++;
>  		}
>  
> +		if (effect & CXL_CEL_BACKGROUND_OPERATION)
> +			if (cxl_set_bgcmd_enabled(&mds->bg, opcode))
> +				enabled++; /* might be redundant */

I suspect we'll forget in the long run what 'redundant' means here.
Perhaps make it more explicit.
/* May already have been detected as enabled */

The whole incrementing of enabled pattern hides that we don't really care
about transitions other than 0->1.  Maybe we should consider making it
a bool and using
enabled |= check_features_opcode() a few lines above this.



> +
>  		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
>  			enabled ? "enabled" : "unsupported by driver");
>  	}
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 551b0ba2caa1..5c7fd4a6704c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -248,6 +248,16 @@ enum security_cmd_enabled_bits {
>  	CXL_SEC_ENABLED_MAX
>  };
>  
> +/* Device enabled background commands */

What does 'Device enabled' refer to? Perhaps reword.

> +enum background_cmd_enabled_bits {
> +	CXL_BG_ENABLED_TRANSFER_FW,
> +	CXL_BG_ENABLED_ACTIVATE_FW,
> +	CXL_BG_ENABLED_DO_MAINTENANCE,
> +	CXL_BG_ENABLED_SCAN_MEDIA,
> +	CXL_BG_ENABLED_SANITIZE,
> +	CXL_BG_ENABLED_MAX
> +};
> +
>  /**
>   * struct cxl_poison_state - Driver poison state info
>   *
> @@ -365,6 +375,16 @@ struct cxl_security_state {
>  	struct kernfs_node *sanitize_node;
>  };
>  
> +/**
> + * struct cxl_background_state - Driver background operation state info
> + *
> + * @enabled_cmds: All background commands enabled in the CEL
> + */
> +struct cxl_background_state {
> +	DECLARE_BITMAP(enabled_cmds, CXL_BG_ENABLED_MAX);
> +};
> +
> +
>  /*
>   * enum cxl_devtype - delineate type-2 from a generic type-3 device
>   * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> @@ -484,6 +504,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @poison: poison driver state info
>   * @security: security driver state info
>   * @fw: firmware upload / activation state
> + * @bg: background operation state
>   * @mce_notifier: MCE notifier
>   *
>   * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
> @@ -504,6 +525,7 @@ struct cxl_memdev_state {
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;
>  	struct cxl_fw_state fw;
> +	struct cxl_background_state bg;
>  	struct notifier_block mce_notifier;
>  };
>  
> @@ -580,6 +602,12 @@ struct cxl_mbox_get_supported_logs {
>  	} __packed entry[];
>  }  __packed;
>  
> +/*
> + * Command Effects Log (CEL)
> + * CXL 3.2 Section 8.2.10.5.2.1; Table 8-87
> + */
> +#define CXL_CEL_BACKGROUND_OPERATION BIT(6)
> +
>  struct cxl_cel_entry {
>  	__le16 opcode;
>  	__le16 effect;

