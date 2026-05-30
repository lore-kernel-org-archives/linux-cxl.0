Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AA36A01A
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780122171; cv=none; b=BdPUPgcf3ZC5JJgq5A/MtddQYUwGUoG/zyX9C+sQqZ55AUI3r7raoVmknXDFaawPuNkFPPkLK7vfstvz8DNK7oahTuBMW/KkNDXXV7M416g9Jb77yLFKzX8jyEHSqEu1fRL3rDI+Bav9YxJ3pLKTxXXFdW0+/N5zE37/lgxpvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780122171; c=relaxed/simple;
	bh=uviwLoz4nPYGyIxxe2AXJWU/UrdAQPXLvUIXPBcTwac=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Stph+R7/1hvrIi5iU3/JHRxp0Q9xZm092iG7OzhhqXKd36txLaUcG0JeMmWXOUvrE+4IPp9HfDwDJkxrTOzr0JtQxfSun5iJ/gyf9yYzr4lJ5EQCiBE7KIORFdZmpHnnNQavrOFlAdO/BhUpq6kCc+TcT7BY7J2SK5e7abRQHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1KjewOu; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1KjewOu"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13621cca8f5so4985663c88.0
        for <linux-cxl@vger.kernel.org>; Fri, 29 May 2026 23:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780122167; x=1780726967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Uk2I9j2H79wQveR82ek06LWu1PUS9S4KJpTOZbkwx4=;
        b=f1KjewOutbtBXZXsoQnJa15SAEsbWc4xVpQ9Vr8qNA86EzRfNp8zVzSKCj/5u+hH0s
         PPBbMmgd3bV8Jg2UK6owWio/k/0WLfRgiLYbzTHq0PWX1wUbwLUfUVJ0CUPVpqZ5M8Pp
         Z8DNWRDrpqdHRaF3QMAJYTiWieyrFeZoKDOZTcHBWqwsonvzZAQpfQQN4zB8nIhocMXy
         zjsT7p310WJcDS2R5Sdypg459tcxMRk9esJg9CYfIo8iO65nc3gBfK5d3i5QbLcJEpzw
         P2xcY+7iY1wzvcXfIkZLdy3pm0FFWdb95oykwTIWU8iWvwjMyrO0K+Vtv+njEDSJa/sJ
         cPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780122167; x=1780726967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Uk2I9j2H79wQveR82ek06LWu1PUS9S4KJpTOZbkwx4=;
        b=lgQN3cDYlBNm/Azoc97Z8OFRWocdNIsDFdx+W97iVAzv6oqHayWnHw8m2gRR/LaO+T
         RQE631N3zMf6oXHNXtssV2+t6DPnQZmsj/KQb6T0lndvTerNJLkwPOfSfCsfJ+PQTo+i
         oizDJmqlEO82d2yvSeTbC0eAHIwS9+mR1XOjIkKr4SZ9UUAFP9WXVHZRmnPbX4tGcbKU
         r8ShDN/XnqHamRrjJ5n4nEQVSlSBE99a9s15DDA05eBQhthgUns1BHmJHul9LCt/3nVx
         vkyGxPuHQ43raC32XShmVz9Lxb4joPy3a5TifwbLxuks0ZkvS6Nsm6Sz29SBkRZCYOVf
         bWpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8E4EG42t/zXlT8q3FO1kjXjVzhQDWKNGfBJZ/tbBKhX5AwJW/V6WYaKR3DWerCXZ8bA28LXtkB6S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqF306W2sWjmsZgg5aGK58IpyL7/3t2yPGd4OjqotAJC10TD90
	4RHjxn53XNxCDBkAjhn6tjHUkQ1nvMSVkN+PrjaHLL1d3nL5UFHmDf9l
X-Gm-Gg: Acq92OGPFcitiZA7f29VhI/4X8eB5XD1/K2l8HtoGu3YMsQkhJ7L0QH7YuTUNBXFCnK
	fSdIlAC9cbvWlBPcGlzZCXgG4FyG+cEPK9mkEJK3LaFXeqBZPRM5AqmFctNJ6R9FlCMmbBsZRC3
	KSHrSXlm7XmxXIb840wYLZvGlM/cRe5YgLh77wHFRBH35KAMEuo7KlVY02vfs99ZtNcA4XRyDaT
	lciIk6GH21pPEoFK4ILBwIFKhnOs0+0eipSHFpCRLUwu0v0bAcLTo23QzkobAaDGdFEPOVG0g0Y
	n+qsCHP0dGpJm9i82AcffuDDlP4jOZlpoOuHAoPX4MqdSnRsAEjLIMsKfq20aquT/xT6ym6nMiW
	QMTtyMK4eZgwUAm/LnnbGOajdeoPSx+JNqhINRq3h6Y4/s8m9X2N6Ebddrbh3peX9hZLDU8ZlC2
	mv7iWnoaC0fpSJQCLGkUYsmyLB80qzbqSgkYHerPpN6rPkbQonETH+azrYpBKQOpyASzIoZMqhJ
	ogRpCSARm69WVXV5Q==
X-Received: by 2002:a05:7022:e982:b0:12d:de3e:cbfe with SMTP id a92af1059eb24-137d4280b1emr1249507c88.37.1780122167019;
        Fri, 29 May 2026 23:22:47 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b36aef95sm2614444c88.4.2026.05.29.23.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 23:22:46 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 29 May 2026 23:22:44 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v10 01/31] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <ahqCNFqlOQQPXa_V@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <4700826deb086665c9e1c643156864eaecfe1fef.1779528761.git.anisa.su@samsung.com>
 <dfab67e3-6592-4bb1-bd5b-7a548f6b084f@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfab67e3-6592-4bb1-bd5b-7a548f6b084f@intel.com>

On Wed, May 27, 2026 at 02:34:31PM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:42 AM, Anisa Su wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Per the CXL 3.1 specification software must check the Command Effects
> 
> May as well update to CXL r4.0
> 
Updated!
> > Log (CEL) for dynamic capacity command support.
> > 
> > Detect support for the DCD commands while reading the CEL, including:
> > 
> > 	Get DC Config
> > 	Get DC Extent List
> > 	Add DC Response
> > 	Release DC
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> missing Anisa sign off
> 
Added!
> > 
> > ---
> > Changes:
> > [anisa: rebase]
> > ---
> >  drivers/cxl/core/mbox.c | 43 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h    | 15 ++++++++++++++
> >  2 files changed, 58 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index aaa5c6277ebf..7ef5708bf210 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -165,6 +165,42 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
> >  	}
> >  }
> >  
> > +static bool cxl_is_dcd_command(u16 opcode)
> > +{
> > +#define CXL_MBOX_OP_DCD_CMDS 0x48
> > +
> > +	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
> > +}
> > +
> > +static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds, u16 opcode,
> > +				    unsigned long *cmd_mask)
> 
> mds not used, consider drop
> 
dropped
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
> > +static bool cxl_verify_dcd_cmds(struct cxl_memdev_state *mds, unsigned long *cmds_seen)
> 
> mds not used. consider drop
> 
also dropped
> > +{
> > +	DECLARE_BITMAP(all_cmds, CXL_DCD_ENABLED_MAX);
> > +
> > +	bitmap_fill(all_cmds, CXL_DCD_ENABLED_MAX);
> > +	return bitmap_equal(cmds_seen, all_cmds, CXL_DCD_ENABLED_MAX);
> 
> Above lines can be replaced with:
> return bitmap_full(cmds_seen, CXL_DCD_ENABLED_MAX);
> 
replaced
> > +}
> > +
> >  static bool cxl_is_poison_command(u16 opcode)
> >  {
> >  #define CXL_MBOX_OP_POISON_CMDS 0x43
> > @@ -757,6 +793,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> >  	struct cxl_cel_entry *cel_entry;
> >  	const int cel_entries = size / sizeof(*cel_entry);
> > +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
> 
> Need to zero out the declared bitmap 'dcd_cmds' on stack before using.
> 
> 	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX) = {};
> 
done :)
> >  	struct device *dev = mds->cxlds.dev;
> >  	int i, ro_cmds = 0, wr_cmds = 0;
> >  
> > @@ -785,11 +822,17 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  			enabled++;
> >  		}
> >  
> > +		if (cxl_is_dcd_command(opcode)) {
> > +			cxl_set_dcd_cmd_enabled(mds, opcode, dcd_cmds);
> > +			enabled++;
> > +		}
> > +
> >  		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
> >  			enabled ? "enabled" : "unsupported by driver");
> >  	}
> >  
> >  	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
> > +	mds->dcd_supported = cxl_verify_dcd_cmds(mds, dcd_cmds);
> >  }
> >  
> >  static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 776c50d1db51..53444af448d7 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -230,6 +230,15 @@ struct cxl_event_state {
> >  	struct mutex log_lock;
> >  };
> >  
> > +/* Device enabled DCD commands */
> > +enum dcd_cmd_enabled_bits {
> > +	CXL_DCD_ENABLED_GET_CONFIG,
> > +	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> > +	CXL_DCD_ENABLED_ADD_RESPONSE,
> > +	CXL_DCD_ENABLED_RELEASE,
> > +	CXL_DCD_ENABLED_MAX
> > +};
> > +
> 
> would be nice to have comment point to where in the spec this is
> 
Added
> DJ
> 
Thanks!
Anisa
> >  /* Device enabled poison commands */
> >  enum poison_cmd_enabled_bits {
> >  	CXL_POISON_ENABLED_LIST,
> > @@ -405,6 +414,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
> >   * @partition_align_bytes: alignment size for partition-able capacity
> >   * @active_volatile_bytes: sum of hard + soft volatile
> >   * @active_persistent_bytes: sum of hard + soft persistent
> > + * @dcd_supported: all DCD commands are supported
> >   * @event: event log driver state
> >   * @poison: poison driver state info
> >   * @security: security driver state info
> > @@ -424,6 +434,7 @@ struct cxl_memdev_state {
> >  	u64 partition_align_bytes;
> >  	u64 active_volatile_bytes;
> >  	u64 active_persistent_bytes;
> > +	bool dcd_supported;
> >  
> >  	struct cxl_event_state event;
> >  	struct cxl_poison_state poison;
> > @@ -485,6 +496,10 @@ enum cxl_opcode {
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
> 
