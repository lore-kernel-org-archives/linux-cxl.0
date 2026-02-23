Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1C934BA4E
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877722; cv=none; b=tl0rOnpZVediwGles1WSsFlyyHUMSc7Cb8p/3ih0JAt/snTQ51nsyF6sLef7df3YaRzLos39naHnlkTFIGdpet6tUEQHGwNQLdQKYmAZAH7aOlY1AYHn/S63hKzLA6xTV1jQ47UAGY7z+Q2i8S2N/kK46pwwd+22nLovzG8cifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877722; c=relaxed/simple;
	bh=5UrKWbH60z8AzJWgYTfvOkixgD9LuwwDtSgXdtBNFpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH72fTqNpUJjCDBtyc2TU5grdEzhwz7iJywZlWp9UY3kjvdF9oeM7lm80r8TD8g8VdiFm3jL+iSFiM6rP5sUZb748GCmPS2l+Cv9ivUOtkOZVqQ9FGOa/E65d76vob8gQdy+psBWHx2UuDJO+VPz+ZndHNcfsGVUFzFK1e5bEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qbewoiqb; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qbewoiqb"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-50334dd44d2so57444581cf.1
        for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 12:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771877720; x=1772482520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/V+i5EB1Fz9GgCSeaGxzlgOmbjjk7pCNXMamPUev+2Y=;
        b=qbewoiqbC86+aq0NbIe6XRfneMjDf44g2/A+5la4mj/HpINzUTpzWzugLPnoBYcltM
         D3iSSE4Jbi8Z+0oCZyBUh3azzfSRawZt3tvgPC1qelFq8S1+aCB+I6Gna/gAuSt2LuFY
         8TtHzf4HtOkrStmgnfjc9n/vTmdHQ1wfYQAyhadJRpdDF84sXN7ulHLheUR40aWZd43D
         yZA1gWK4F3LJ2yJwH2vx3fLHZD9YjZW0edmRLERMpC/Tc+DeyvfoIMEXsshtkTzX7wp+
         8fhySpXesuye5WY1da1FOHKX6zjZwcO6eXZLLMG4vNnj/VbvPbij8H8PworQeL8hINrU
         1gtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771877720; x=1772482520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/V+i5EB1Fz9GgCSeaGxzlgOmbjjk7pCNXMamPUev+2Y=;
        b=hOYCZURp5bs2JtSYmbg7CJE7RzsvVfnSwuwSf5x2+K1u+RCLldUTE2goJw9oj7L8+S
         lUlC1P/5+qsIS+MwcTISCwoHd9npVeuA0dwxrmOrCyLTMsK8Lgf9UDDl1kPisMm26nhN
         Rnz4z1B2GFV3Ix3PIyw6b/DDiuYadenrzX/xGMduKKyxKTX8xA0cqwigm+BXj16WTZqM
         yUnh8CPOlxplHsROBqJvr6vQe2IgTOexGzEc9LpkJXUbPYTv6sK5Y8IaErSLCUt4D8kD
         0T+ZSbCvrjQjUZNxG9ONA8IxjdpneosZbRCO2t6VsG/8MGQofgEP+FAhowoC/SD8o74j
         6c8A==
X-Gm-Message-State: AOJu0Yxrr46NWkYNcaXCc5Wr6NumIGB8DiITPyWytMqABLZwItWtJ3/w
	LO9/WmrtfB7MOR2ucujjAVDs+R7uDwCX3anqNUMpyOyGkQZ1okD1pJzfjkzUW5Cg7k4=
X-Gm-Gg: AZuq6aJiUosixNT4zqto1Umgw+fLjlDrpoy55864tND6SFplBcvfANmMVrcJqoqpV49
	vcKbQEKCBjCGeErUrfGTkmehGpEs1CjJZjCUP2MjZlx6sU7tMnU6OAcpF15El108FcGjVhePic1
	3YXWjzRr/Zos50CsI3oXVDoWgtMmX+pWMZXrljPRoh9SMY/HMEiEIS8dmmlXeOu+eYETI8yXJP1
	ZqqbAnvm+b/YEy7YAYIOMRXmvkv4Q48xF7UqHKF8XKYPSoXZwR0w5WOxL3rUsvYq3+WYf97HpmE
	djk9bq2fTzz0Hf10Dj2LRzePCEGLEYrJ28m/MYbvzQe8Hgn10Vc5uL6C3x/fMKBjtU7i7CEav4M
	TmOCGFjrwkOaNri7AbYW3jqP8ym6kDKjepcFnNF1jMLHm6fSMDWXSbjT/QaPhuOLXHcZLPLNZMn
	+XEqKpgV70hNsrqSLAdaIE4orX0L3BE0Q6nqdmOk68gQYRZpkOYGc/vy9nvv7LPzUe9Dzr8tQdc
	J1QpwaFkA==
X-Received: by 2002:a05:622a:1485:b0:4f1:b787:ebb6 with SMTP id d75a77b69052e-5070bca7ademr141331391cf.55.1771877718160;
        Mon, 23 Feb 2026 12:15:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d50cdcasm79800991cf.6.2026.02.23.12.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 12:15:17 -0800 (PST)
Date: Mon, 23 Feb 2026 15:15:16 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 1/2] cxl/region: fix region leak when attach_target fails
 in cxl_add_to_region
Message-ID: <aZy1VGindEm-NbFn@gourry-fedora-PF4VCD3F>
References: <20260221043013.1420169-1-gourry@gourry.net>
 <aZyvGnKfWI1Mku-c@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZyvGnKfWI1Mku-c@aschofie-mobl2.lan>

On Mon, Feb 23, 2026 at 11:48:42AM -0800, Alison Schofield wrote:
> On Fri, Feb 20, 2026 at 11:30:12PM -0500, Gregory Price wrote:
> > cxl_add_to_region() ignores the return value of attach_target().  When
> > attach_target() fails (e.g. cxl_port_setup_targets() returns -ENXIO),
> > the auto-discovered region remains registered with its HPA resource
> > consumed but never reaches COMMIT state.  Subsequent region creation
> > attempts fail with -ENOSPC because the HPA range is already reserved.
> > 
> > Track whether this call to cxl_add_to_region() created the region, and
> > call drop_region() on attach_target() failure to unregister it and
> > release the HPA resource.  Pre-existing regions are left alone since
> > other endpoints may already be attached.
> 
> I see you dropping this, perhaps just for the moment, because
> the drop_region() you wanted to use is not available yet.
> 

Yeah it's not a particularly useful cleanup in the current
infrastructure because nothing actually uses this pattern (yet).

> This looks a lot like 
> 	https://lore.kernel.org/linux-cxl/2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com/
> 	cxl/region: Unregister auto-created region when assembly fails
> 	When auto-created region assembly fails the region remains registered
> 	but disabled. The region continues to reserve its memory resource,
> 	preventing DAX from registering the memory.
> 	Unregister the region on assembly failure to release the resource.
> 
> And the review comments on that one, or at least on that thread in
> general, was to leave all the broken things in place.
> I didn't agree with that, and hope to see this version move ahead
> when you have the drop_region you need.
> 
> 

The important note here is the difference between auto-regions and
manually created regions.  For auto-regions, you might have another
endpoint show up looking for the partially created region - and then
just go off and create it anyway because it thinks it was first.

But in my driver, i'm explicitly converting these auto-regions into
other things, and if that fails it causes *all other* region creation to
fail - even if it wasn't actually dependent on that original region.

This is only an issue if you have two devices unbind/bind cycling at
the same time - i.e.

   echo 0000:d0:00.00 > cxl_pci/unbind
   echo 0000:e0:00.00 > cxl_pci/unbind
   echo 0000:d0:00.00 > mydriver/bind
   echo 0000:e0:00.00 > mydriver/bind

If the platform has pre-programmed and locked the decoders, and one of
the two devices fails to probe and leaves a hanging partially
created region, the other device will fail too.

It's a pretty narrow failure scenario.

~Gregory
