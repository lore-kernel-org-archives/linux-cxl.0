Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4423815B
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672744; cv=none; b=Hti5G3/fqrTTmuFTjCE3KWH8DiP5adtVrRHBjpHfs1+uVj3dk8kZfIbno5YDrtwI0loqE1ohGnLP2dvHcbNLssfozSBj6H3l9/LoIHFqVDWXUrZx1TigYURRhci2EIOyj5agqG3oQMG6+vRWBpo4OgGwlL+HzkMNbABd1cZBGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672744; c=relaxed/simple;
	bh=/zKnBOxICMcZw91Ph/QZZ5zni/3oVabpUEVjglg4pqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKcruTLjeZ4vv7gT+ESQ2QIsDTDtGm0AiT8mNUPLpOLlV5Pzq5TPsnT+Hig847QwH6Mcq7+XqFna5Q90j2ATUP9nhOVg/Uwynp0fEj8SX5+6UECig3HjA9ioJG8gvlivIxY3GUvB4XAFfROqeCm6mWRcTmOay3+vZ3ns5byyTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=s4dijsjx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="s4dijsjx"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a05955720so45358136d6.2
        for <linux-cxl@vger.kernel.org>; Wed, 04 Mar 2026 17:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772672741; x=1773277541; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b/K8oExowzofbndlmLRvjuXWIIQ5XDDj++/GQGtDPio=;
        b=s4dijsjxaIrX6GT/LC39ZJE+nsJuDK5i2bO34vqW/4OBaCNLrvJGQGrG74BR2oDCpC
         Svzr/qdjuf4ztEUMh81DhufQcjn2etz07Z51rpAmh+tAYWMnxte+8UtMOapzCm5Cd7C3
         VUlUP4rCcNTxUvlwq4wPwHen+QTq7DhgDdxDK5Pq5Q/t05NceW8Ix1MW7x/hqzR2tWIv
         ULL/kd+OBeYfT+0EO3hm7uJ74Ob1jau0Icdy005okdpetNc8s8cI0ySZffkwXuvkV9iR
         g3NseWfeWvsxDtY/9r7h4FMCbMeTVexDdlhN3q7HxAG48/wUb9aeLwQcXDqJv5wgYRVK
         XRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772672741; x=1773277541;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/K8oExowzofbndlmLRvjuXWIIQ5XDDj++/GQGtDPio=;
        b=ry7RCp6oZX/SfKA5fCcCL1XSbm89i6Gi1NDXjBPcFCxNnjWqoNLkewtmCFvY2ShBDx
         ECIkV5Pjh9irs0Qqz4uPUchP3Z11jtpVseQXzfaaXrsmmnPfYoH4W+kWwE7360J8SXyM
         v/gjjYPcZl/+/nfcMyDKrJrhS5+8EDaEeK2tW66quRoWySxOe9S58UYtwDnjYoEx8Ho8
         puL85RRzwYR2Tg93PHWKSWpCzavo17Wbyd9F4C134Fpwn5YSBWtMudpJMVf0nT3iJv5Z
         G3Ys62d5tRNwqragsOQIxKGyVVld7ZL/VxpCKj+QZojTefxzfnsiFdaA23jofvsG7bju
         1ZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW69jIe1rfpT3Y/UPp6qiDsSerB+tzEPPwTnfYMS5Y4Ix1FhZW3HAiPlTWaY+G3ITicfDjZk9qqJMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx2LjdqSQDSlI5Z7v49ropjpuyHu5anDdwwPHijyHKbsn2Ut95
	PY9t9LUXL4MiXK5CjEpfa4G3P2MJmUMJ9XnZ6fxclKo5oiUwbUa3x4pidsX02EP0J3U=
X-Gm-Gg: ATEYQzz3UiuErCEOGoL7qG0TLTjfkxXxCnN5/wzxhlS32ow5uo+A8cjzDT0n7DNqEr1
	JZWa2Urr2fVfRxAfaoQsU/vNDdGjRi277TfmEDyGAQtw8ftLa5VrnD+UNTKFgGRD/gYdL1MpHNe
	igF/1Z+/oV0ZnAicjeK0aMipC8902ItCZPPl4NnQQGt218nwS0zxr+TRKeqoI+Lz7Z+EGb3liz1
	0nMAPrQAKKZ+usm3DzIn9KUdvezDSPhyQOAQ3iZn4FZiFbdptpjTWdAdI+Q92Tu5PIPkbwAcDRd
	rntQh2qMTsyFJSFkOCyZvq9EGgciqlB/ASlJMQ3gewIFkGwX6dRoNkwqxENtTVNMJyt2oR4A3eG
	ZDHZ/jerwaQ1+MoJecp8w9WzG4cKT4hwovESVbQHmaKKr5qPJG7MtT8OVgMOuyQssF5P+HFQnTH
	SROw10FDa8n7gym+/IN+eOECIGQEURn9xQBhFbd4qZcXNIkjSwrULLIeCcvJNNgqi62gATbd7gu
	Nf0E01UGw==
X-Received: by 2002:a05:6214:411e:b0:89a:170b:a6f6 with SMTP id 6a1803df08f44-89a19aee4d7mr54977276d6.37.1772672741289;
        Wed, 04 Mar 2026 17:05:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899fc21676fsm81448586d6.22.2026.03.04.17.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:05:40 -0800 (PST)
Date: Wed, 4 Mar 2026 20:05:38 -0500
From: Gregory Price <gourry@gourry.net>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"Schofield, Alison" <alison.schofield@intel.com>,
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
	"wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aajW4lDhuvoQ1nWF@gourry-fedora-PF4VCD3F>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
 <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
 <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>

On Thu, Mar 05, 2026 at 12:45:39AM +0000, Huang, Kai wrote:
> > 
> > You are taking something away by nature of compiling something out by
> > default that was previously not compiled out by default.
> 
> Yeah, and it is due to "there's a cost" if we don't compile out by default.
> 
> Hope that justifies?

Sorry, i don't mean to come off rough - I don't even necessarily
disagree with the change here, but it is worth taking a moment to
understand whether this is actually a Linux issue or an platform issue.

Up until now there's been some assumption that if a device is attached
there will be CEDT windows - but this would be the first time i've seen
a platform throw up CEDT windows for devices that don't exist.

Anyway, this is good information for Linux to know and worth a comment.
We don't know what other people have built that depend on the current
behavior.

> > 
> > Well, I'm mostly confused why there are CEDT entries for hardware that
> > presumably isn't even there - unless this platform is reserving space
> > for future hotplug.  
> > 
> 
> I think this should be the case.
>

If that's the case then cool :]

May be worth a comment in acpi_numa_init_cxl - something like:

/*
 * Some platforms report CEDT CFMWS for hotplug device support. These
 * windows are unusable without CXL drivers, so don't reserve fake nodes
 * if they're compiled out - it wastes memory on per-node structures.
 */

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
