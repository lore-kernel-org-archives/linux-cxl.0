Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEEA2E5B19
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056622; cv=none; b=IyhAJ8oehUH/Sk/7K5eiVp9fM2IYLXWLZ+JQegMWw/iMjSWIEM0r8MKge+ezZsohskSP/ZClLavu9pRN/i2FY8NP794ajWcLSR6DdZiydxIeD9qn0KkNbGTPZ5ZwZQi7wP/n98lV6p5UCSuqVh7MgXhO0eu/l4eRu/5Uu9ablLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056622; c=relaxed/simple;
	bh=ADF7ZKoCipxDP6UUmIGW/IPztV2DncS/DM4/x+XvBnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNFAhCc5FmRZqFBUgpXAUvhZ61BiOvSPflAO5fSw7BjY8w9AMWSlHJ4LlicY1ty9ODigcqKaZo5Og/6PNk1vEuEmF7/MkIJ+uIGa9+fdAvtSzC7D0sfOBvMbPuVJ5GgKLf7vjrtIs7Xm13JeKgJik1Va/OfcW7nXOOHjI/HiPow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=InR81NOc; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="InR81NOc"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a26ce6619so62644176d6.3
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 10:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770056619; x=1770661419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MqsmEA1l4K6M349TDpqaFt5arK8yfZiMH/3re7GUwy0=;
        b=InR81NOc+P/iyRLUJkh38ul0bKeuarPFPiVT8NeFHBjhUd6Vmo6R/C9sN5zRQ28C8M
         hEhdNiuaxy6eA5E4vV7dHMOTxed3M8H6zFl6luU8RTKoll1Y3WqFSnV86JTTkuCuL3jD
         nzt3513DmVtY0QTBkhvh9DMPoVGO5E1o8hbpd0P3sU5NQdQHBmGp2BwRH0p4IdJoALv7
         N2tDwHK9yxaq5iqwv+4itd6iPtnz+/ziKgHAPec2W545IzfQRlR2LEHwsR6DOnF2Pmxx
         S+WGypfw7xh3HvuRDMsP9+ZTeSR5PkQLTaKfuMKd3sdjHJ4kB0zzvrvDgrFBjTmBPp3F
         J2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770056619; x=1770661419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqsmEA1l4K6M349TDpqaFt5arK8yfZiMH/3re7GUwy0=;
        b=LYEVXfRMVlQvktyJatvKOQKVRULIPYMPsoP91myAOAf3O5Fw7hiIWi+ZUPs7vdiwhh
         4kt60j/yj4ZrbUAXEtcyoMl+vPMG3tpUNlItcp+Z/AQ6Ledgo37ALmQ8pxOpJiCn1HpP
         Zamncqt54Pjm90rv8WsQdkB471daR7vVvJxb/IYQETaY9aqtDouX6SPeSr5Pv0NbmZyb
         sMrE6ar+TrQQCB4h/BWkdRT66PbWKPp60WW3kZ18TDuKtrvg+jIi0fpVEexmlYXfnAVV
         iVYctGdhjaJXvlM+u8fQZKoW4am+XhbqLHzP/JENbiPzTawvZum5spGIySjj6nl9S8jZ
         BuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm+J+U1gyLm0a1+pgkGEi42/WB4aZ+gt14gIhLkh5rmvjnNr1cpeLHXXuU9P+tdt10q4ods6TyUNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1wLMDW20RjdMreF+S+vyPKZMv3L4OKNI1evbUDKTWKFJUuYs
	QQwTUN0NKbC3zKmdGFNjUecP1DGjGa4ox5es8nYx+Nl744jmaCz9upB2CZ911sSDA64=
X-Gm-Gg: AZuq6aJLu+vVZU5MXgn8gqtA+6FSbk093892qCJ5e/0FpH41c+66NS4Kkxm4C4nRuIQ
	jKBYM5xw1196RwmzV7/zO3uTrxkoaez2WVcIsEbKGTxeTEGyK/ZuWohfZcRZ3WH7GgoxWIxpiYZ
	W1LL9vIF7FBEFcqEG46aU2HbIoE/1NaSbs3hbcEHPmxQppK6ga7l7WUJplk+tA0aiPXQHaTyYBE
	NKmlMgBGs/JGR+5/fs/brPh29x0mkqEYmLcrS+rdQqKVra2KRUoNRNkj8ZJhtriBwYGg+hHYu/8
	5Y5YAG2Wi2SlVLJgFbWOCKjit10G2EZFKT6qtftWiQo82hCSqk9sUIzLkcBkRjs2Na1buH4Dw2N
	xzbcn2DOzTCJMkuJcaaHDFK/ptOsZE+jR5JzdLmykMuUvMeblPD3ALIoNxsB8PLrCNkwZRPsdxd
	fQDmHgXW8TuBmIZutqIIPwuHYj8jq6597/9cUhHP217UfI7qo2nVK6+da8lSuU6UGgnGxadQ==
X-Received: by 2002:a05:6214:e87:b0:894:6558:58f7 with SMTP id 6a1803df08f44-894ea167cbbmr166333016d6.63.1770056619523;
        Mon, 02 Feb 2026 10:23:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm1089477985a.46.2026.02.02.10.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:23:39 -0800 (PST)
Date: Mon, 2 Feb 2026 13:23:37 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
	terry.bowman@amd.com, john@jagalactic.com
Subject: Re: [PATCH 8/9] cxl/core: Add dax_kmem_region and sysram_region
 drivers
Message-ID: <aYDrqVEOwkGfv2JG@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-9-gourry@gourry.net>
 <20260202182015.0000325b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202182015.0000325b@huawei.com>

On Mon, Feb 02, 2026 at 06:20:15PM +0000, Jonathan Cameron wrote:
> >  
> > +/**
> > + * struct cxl_sysram_region - CXL RAM region for system memory hotplug
> > + * @dev: device for this sysram_region
> > + * @cxlr: parent cxl_region
> > + * @hpa_range: Host physical address range for the region
> > + * @online_type: Memory online type (MMOP_* 0-3, or -1 if not configured)
> 
> Ah. An there's our reason for an int.   Can we just add a MMOP enum value
> for not configured yet and so let us use it as an enum?
> Or have a separate bool for that and ignore the online_type until it's set.
> 

I think the latter is more reasonably, MMOP_UNCONFIGURED doesn't much
make sense for memory_hotplug.c

ack.

~Gregory
