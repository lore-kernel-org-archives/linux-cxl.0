Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514E3CC7FF
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492775; cv=none; b=G5KKmaDpP2PaaPAhuioIgeOBXDlkOFy79e/qE8XJdNAYrKJ/z1t8GYYD4cw32bKq6TQhH0MsrGXF4I9WYYrxaky5Mz67MP+fVWGI7fu21VTnFy6gc1m2bsdYIXCwlFadv6UZ0AlZWiiynoLjT3UxIBs35M5Ay3t639WtSDKa3Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492775; c=relaxed/simple;
	bh=Yby1lU9VN6HYpQppwiYSzNoMynAI71dJoBV/rnJzqs4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx5K7S5dO6f2RYwi/lF6PMu9KzyNkSkDXJfzcdgrl3mmYL6MDt/l4Ar9gwMysehqyztSozFmBdtPFRI2x9ZqU+G5SIfyHn3sZSM9EKXwbeyGa2RfAZivTmFWNPurJJp/D65eApcFLFqmmBD4WbuZEqEyFfaGeoz6o1ochk8cgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbcByM6D; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbcByM6D"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469a34908so2990589b3a.0
        for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789492773; x=1790097573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L85CFCPvXgAawOWXbDFnQrvW/dJoYBB9T/dl4xReqb0=;
        b=XbcByM6Dg2u5hexkEEzetxkXfgyu5CE3jzE69vBD7QLd/t1hgnbEXIq9HJk0gcGOiW
         FOWu/uOTwiI4trUPAN8bOBeXMZRtRrmsNGPjniaLkv/kruS+Xm46yf8OqrsE+Yr6eD9M
         gfvamZizNNNiZpTUF8CM14zLu5kRqeQwkRx46hKhhzBOfRbQnwF/TxFum/xYeu2/Qj7K
         LAEVaiZZ2Q0nN1bNIQO1s6YrInhtsAiQvqmBc48YVEaTo3z+G8DICWCpPP8dr6dI+CE/
         ATD+GQDkabXG7u4MorwSw0ySR4F6+p4k0/WYiAQLESxGj09UqiEgDTRFjBGwzung5s4r
         GUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492773; x=1790097573;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L85CFCPvXgAawOWXbDFnQrvW/dJoYBB9T/dl4xReqb0=;
        b=eDmnQi6zFbkQb6Y0x4R+AFaQz0JycTFk3EBci6m46QVdjqPdVt+AUon0fTX1zJjaLu
         rev4XyDSoBVi5DhdqmGuccNFO8bdxKA8RW3ovgGTK8eBoJrDQTNk3m5fDDTzTtD6Ju1P
         0SDd+4IMqCPOa+fZsrVu+HWhKWTEWKf5KKSBBJjhUbRAAXVOsEExiyqvKeTfRHOA2Ia8
         IpcCUpBXfs0+L2/g9DB1u/ax83RKDjoKIZ4696rTkgi2GMgocO4CK6P7jZZr0Y4JW1vH
         C3NT2ODKwC1YbIsNCcO39t2wiz1USJAjhvWUQhRFgfbKAUJHzrv4XyIu83eTJhNLv5sE
         BJFw==
X-Forwarded-Encrypted: i=1; AKwUvBwLm3rCcSpVGu8MBm2ZKEw8+IaML/4QnxYzEupYDkBOda26jJuKBHsBaD1yE9toA55R59IDcsiiPr8=@vger.kernel.org
X-Gm-Message-State: AFuF++lZN5Cs9ym0JGWTYTLu0rmCYpSJ1bcnU/wwlsmkmE8M+C8f5xZ/
	ZrTXbmqVaN+rfXx6RC2NyIjDsD+F32pFeHLnejTyHI9QHeLdRF5yD7TYPS1KlGCp
X-Gm-Gg: AYBFou3hyyAjVWKw5rZb9LtoJ8S6igVUyHlJUEPAXZ7U0fxvpKrkqbNP+GtTjoGBczD
	ZvszIzUM6eJvqhuCoEB58ch+RHFn+AdLsOEqCFZeI8Lv3A1+9xYW1SPtIwGI8H+mFvMakMhSEbZ
	AzcpGVjdqwMD4Cqa7tPISX9uwjPe/9dSQGPWe788T9pMsIHlLLdIN5C4IUvm3j8VDoI6Hax5acL
	vx+08j5Eb9eGMld/8MxxWXaZV77XDw2Y9JqryMWkJjseAWlYKmUPlL1YVqUU4AweOFztHL2ZBg2
	3DpCHke8JJE9vviKrpWv10rTXathRRPG9g3LGq2ggl5hdrcEEb3ZUPtnJk9oi6Ut1I9rC95AP1j
	93c6BWaQgok09SU9u6r9zV6TZwmGEe5TSkyeXZinxhgCDsIC7SG/hUQZZF4MQdzNQVlzUSaiUdl
	CSUp9jyJKyBEfoELwPdGUYCQOIwvDbuxziIx0Rw5tDBQfC6spEZD7QgO14J5RdklrzDZ/vfakpe
	zzt1irXmmUlyF/DbjEhE/LUmgmHmTUaBVzF
X-Received: by 2002:a05:6a00:1a10:b0:870:ef71:e8c8 with SMTP id d2e1a72fcca58-870ef71ebadmr6628030b3a.12.1789492773169;
        Tue, 15 Sep 2026 10:19:33 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8716f863395sm945735b3a.17.2026.09.15.10.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:19:32 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 16 Sep 2026 02:20:43 +0900
To: Richard Cheng <icheng@nvidia.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, jic23@kernel.org, dave.jiang@intel.com,
	gourry@gourry.net, ming.li@zohomail.com, vishal.l.verma@intel.com,
	dave@stgolabs.net, benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 1/8] cxl/mbox: Flag support for Dynamic
 Capacity Devices (DCD)
Message-ID: <aql-a1fq346iD7ek@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-3-anisa.su@samsung.com>
 <aqjsuqQP0dmgJyJs@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqjsuqQP0dmgJyJs@MWDK4CY14F>

On Tue, Sep 15, 2026 at 03:04:42PM +0800, Richard Cheng wrote:
> On Tue, Sep 08, 2026 at 03:15:05AM +0800, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Per the CXL 4.0 specification software must check the Command Effects
> > Log (CEL) for dynamic capacity command support.
> > 
> > Detect support for the DCD commands while reading the CEL, including:
> > 
> > 	Get DC Config
> > 	Get DC Extent List
> > 	Add DC Response
> > 	Release DC
> > 
> > Leave mds->dcd_supported false. Dynamic capacity is only usable once
> > the driver can handle Add and Release Capacity events. Detect and log
> > the capability here and let the commit which adds DCD event handling set
> > the flag.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> >
> 
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> 
> Just a small nit below.
> 
>  
> > ---
> > Changes:
> > 1. Commit message: explain why mds->dcd_supported is left
> >    false and when it's re-enabled in the commit message.
> > 
> > 2. mbox.c: drop the single use cxl_verify_dcd_cmds() helper and test
> >    bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX) directly. Reported by
> >    Alison Schofield.
> > ---
> >  drivers/cxl/core/mbox.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h    | 20 ++++++++++++++++++++
> >  2 files changed, 59 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 55828a836c01..199bb986d674 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -171,6 +171,33 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
> >  	}
> >  }
> >  
> > +static bool cxl_is_dcd_command(u16 opcode)
> > +{
> > +#define CXL_MBOX_OP_DCD_CMDS 0x48
> > +
> > +	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
> > +}
> 
> 
> why not (opcode & 0xff00) == CXL_MBOX_OP_DCD_CMDS
> and #define CXL_MBOX_OP_DCD_CMDS 0x4800
> 
> so we don't have to shift bits
> 
> Best regards,
> Richard Cheng.
> 
Hi Richard,

Thanks for the review :)

This follows the convention for the poison and security command sets.
Ex:

static bool cxl_is_poison_command(u16 opcode)
{
#define CXL_MBOX_OP_POISON_CMDS 0x43

	if ((opcode >> 8) == CXL_MBOX_OP_POISON_CMDS)
		return true;

	return false;
}

So I'll keep as is.

Thanks,
Anisa
> > +
> > +static void cxl_set_dcd_cmd_enabled(u16 opcode, unsigned long *cmd_mask)
> > +{
> > +	switch (opcode) {
> > +	case CXL_MBOX_OP_GET_DC_CONFIG:
> > +		set_bit(CXL_DCD_ENABLED_GET_CONFIG, cmd_mask);
> > +		break;
> > +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> > +		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, cmd_mask);
> > +		break;
> > +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> > +		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, cmd_mask);
> > +		break;
> > +	case CXL_MBOX_OP_RELEASE_DC:
> > +		set_bit(CXL_DCD_ENABLED_RELEASE, cmd_mask);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> >  static bool cxl_is_poison_command(u16 opcode)
> >  {
> >  #define CXL_MBOX_OP_POISON_CMDS 0x43
> > @@ -759,6 +786,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> >  	struct cxl_cel_entry *cel_entry;
> >  	const int cel_entries = size / sizeof(*cel_entry);
> > +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX) = {};
> >  	struct device *dev = mds->cxlds.dev;
> >  	int i, ro_cmds = 0, wr_cmds = 0;
> >  
> > @@ -787,11 +815,22 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  			enabled++;
> >  		}
> >  
> > +		if (cxl_is_dcd_command(opcode)) {
> > +			cxl_set_dcd_cmd_enabled(opcode, dcd_cmds);
> > +			enabled++;
> > +		}
> > +
> >  		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
> >  			enabled ? "enabled" : "unsupported by driver");
> >  	}
> >  
> >  	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
> > +	/*
> > +	 * Disabled until event handling implemented.
> > +	 */
> > +	if (bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX))
> > +		dev_dbg(dev, "Device supports DCD; capability disabled\n");
> > +	mds->dcd_supported = false;
> >  }
> >  
> >  static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index c401e3a1af06..0c8e23276dc6 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -252,6 +252,20 @@ struct cxl_event_state {
> >  	struct mutex log_lock;
> >  };
> >  
> > +/*
> > + * CXL r4.0 Section 8.2.10.9 - Memory Device Command Sets. See Table 8-308.
> > + *
> > + * The 48h Command Set (Opcodes 4800h - 4803h) defines the device-enabled DCD
> > + * commands.
> > + */
> > +enum dcd_cmd_enabled_bits {
> > +	CXL_DCD_ENABLED_GET_CONFIG,
> > +	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> > +	CXL_DCD_ENABLED_ADD_RESPONSE,
> > +	CXL_DCD_ENABLED_RELEASE,
> > +	CXL_DCD_ENABLED_MAX
> > +};
> > +
> >  /* Device enabled poison commands */
> >  enum poison_cmd_enabled_bits {
> >  	CXL_POISON_ENABLED_LIST,
> > @@ -427,6 +441,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
> >   * @partition_align_bytes: alignment size for partition-able capacity
> >   * @active_volatile_bytes: sum of hard + soft volatile
> >   * @active_persistent_bytes: sum of hard + soft persistent
> > + * @dcd_supported: all DCD commands are supported
> >   * @event: event log driver state
> >   * @poison: poison driver state info
> >   * @security: security driver state info
> > @@ -445,6 +460,7 @@ struct cxl_memdev_state {
> >  	u64 partition_align_bytes;
> >  	u64 active_volatile_bytes;
> >  	u64 active_persistent_bytes;
> > +	bool dcd_supported;
> >  
> >  	struct cxl_event_state event;
> >  	struct cxl_poison_state poison;
> > @@ -505,6 +521,10 @@ enum cxl_opcode {
> >  	CXL_MBOX_OP_UNLOCK		= 0x4503,
> >  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
> >  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> > +	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
> > +	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
> > +	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
> > +	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
> >  	CXL_MBOX_OP_MAX			= 0x10000
> >  };
> >  
> > -- 
> > 2.43.0
> > 
