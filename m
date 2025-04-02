Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124C33993
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603288; cv=none; b=sqheJVU7+xf0RH79BomRH3wm8XKe3A4CcdekYIqoQB3iGi9IXEiHeYbUIOdjQyqiLaHr98AsnsErMpNV+fMRavZnk/Vi9vo/1Cejgrk40lUSc1QPDPa/6q60NOw8BvwgP+LqkW1+Dz0uRsEE19xIfkoO3FOg3tzWWHqeg/xjdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603288; c=relaxed/simple;
	bh=UGyb8qo2Qvq6WmsRJYAhTFCRlnp4k7a+5kTcauPXtMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4cmmIxp1WmhPDO2g4hruLPnXrqkzQ5x9Vuc9DD/W3XAl9y8n/4HyvfYzQJq28jIJA8acxsdWMc/oVegob3fEY/vW5qFSfK8F2H4ZLXG22LbcbvsVXE677siU9yX4XbywaMq5mV0vMzQgD7/gZUouzcCv4MPmmYiTN7bsjFMHho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=di3eFfXj; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="di3eFfXj"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c542ffec37so686410985a.2
        for <linux-cxl@vger.kernel.org>; Wed, 02 Apr 2025 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743603285; x=1744208085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UkL808QoOagxPn1CA7CvE/Yc8W+p4mA2vccj1YTlzs=;
        b=di3eFfXjyGTkatSpt4Bphf98d/29Mww8WuMVzA+jWZOX32kgdO4xd82XG2jrkAnSOb
         HNG3y+4kTqA9+zNMfaO1T1VP+lvYCCVovSgqVqc9YenZcCJq560Ezlaj2T2yzpb0lBYr
         Bg1guCav569P/WjDxkuOUPgI+IW1bcY2GgK9tV973s3RWgMP72cJJ+UaKw2qgZ3D5ELD
         o5ps2p6+5IeFdzrWHeQ1KT4xDWyc1KOJAsOE5dSLDDR4DIzKDgnahBkGp4RkqlZ7Kprg
         IluKl+jZHIJxbBFPScYFb/lvIp3GOWlp0IOcZUTIHjWYWIyegos6F8gFO/T6fNB+HdtJ
         2D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743603285; x=1744208085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UkL808QoOagxPn1CA7CvE/Yc8W+p4mA2vccj1YTlzs=;
        b=fMJZNSdnHM1/qrsbWpRAwIm1Uf6KovIIMjNt1+XarXFx0qvJclDkZ7k8E5rEdvCayO
         Y+b13AwChlTiPZ0MY1sWsaWZfEnOU6YXBvfYI+xHpcJvRqidtLwkoM2gm7ih8he2Ow/+
         V1b932XQ+0RgGUBWB/oAPIf8Vl1uckoxwbGj4C0LN3yX5b8ledxL1y83ZQYA08u2Sick
         p54QzxfDwkOjmsmHlTEK2rRZ9zdGvbTN3qEMBo8zL9vYp6AgUA5novb/OfDxAhm1ywlZ
         icgIha7VEI470aMRDVz3GjMUQpkwuoLptEiUC5f+Az/DG2JGmvAv6UULxwTU3LULRqlB
         il5w==
X-Forwarded-Encrypted: i=1; AJvYcCU4HMJRhZg6YAZUWBr0EwGWUuuX64HBQhmMQhVvc+rGgEX8s6ZLstdQUx+6/LlLw4TBO7a6orwL5w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnl2CBNNO2NU0i3Aq1R+0LhL46c2LuoFLhglBp/FCra4Op/6G5
	CDpgThj/3XdksYKYcJJv8qCwov8eWJMOngt4OxpZ4I4NQGp3mRCKfoAVGgT5wivG61+h/fHCOyw
	B
X-Gm-Gg: ASbGncuWuFEL1jo9u7gnx9DLpJnledrQ/5L3JyehjHVf9/C36znvn7Odg89MkxkVziC
	RCotXa3x8tav5EHPsMU8K6Ovg8Invg8zsbtpDNAuElnXAeJxT+XVS7zRGp9JFfJWAY0jdZCySBF
	7avpaoWnHsAvh8KF3QtgkT3Bm+g/kAyQD8qaCWk09OcLYYBR8KvpknEUdDMe1rFLxoehXavjMgE
	pMX2BzaIfEDUfR8T8Wn2xUeD5PhGRNvdq1erLTRnIgSoGWwX2dRrQvbcb2EKQ5wvHT0w6++Aw4l
	7rcg5Cmy3IIe5m23ggdGFs4kUVCj9y1z5mZ31RdEz0Mhbsk8OmhOq3p868nuS8GzN2f+LUK+641
	mt95qNwYjbg0x4r2vfxMRjG66pOc=
X-Google-Smtp-Source: AGHT+IF+VKt9eqjk1q7w411mxoZKToWyH5/YzFwvHa2gfGrBQuMo82PAI2uSF+0IBasFLzRff+rDuw==
X-Received: by 2002:a05:620a:19a5:b0:7c5:5584:dc1b with SMTP id af79cd13be357-7c7664f4655mr417448285a.54.1743603285123;
        Wed, 02 Apr 2025 07:14:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f768e3cesm786174085a.46.2025.04.02.07.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:14:44 -0700 (PDT)
Date: Wed, 2 Apr 2025 10:14:42 -0400
From: Gregory Price <gourry@gourry.net>
To: Oscar Salvador <osalvador@suse.de>
Cc: Rakie Kim <rakie.kim@sk.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com, ying.huang@linux.alibaba.com,
	david@redhat.com, Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z-1GUrdcOeYQgkE3@gourry-fedora-PF4VCD3F>
References: <20250402014906.1086-1-rakie.kim@sk.com>
 <20250402014906.1086-4-rakie.kim@sk.com>
 <Z-0IlZgYLjogZSZO@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-0IlZgYLjogZSZO@localhost.localdomain>

On Wed, Apr 02, 2025 at 11:51:17AM +0200, Oscar Salvador wrote:
> > +	case MEM_OFFLINE:
> > +		if (!node_state(nid, N_MEMORY))
> > +			sysfs_wi_node_release(nid);
> 
> This check is not needed.
> 
> If status_change_nid is different than NUMA_NO_NODE, it means that the memory
> state of the numa node was effectively changed.
> So doing:
>  
>   case MEM_OFFLINE:
>           sysfs_wi_node_release(nid)
>  
> is enough.

offline_pages will call this callback unconditionally any time it's
called (and succeeds).  If 2 dax devices online into the same node, it's
possible to offline one chunk of blocks without offlining the other
chunks of blocks - which is why we did the additional check.

~Gregory
