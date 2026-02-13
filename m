Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C508D35D5FA
	for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991495; cv=none; b=d1CAAqmp641FoDF47IkiAXb5+yPAoiVSVKGLjwxMh5TA+7k5dfEOSCDkMzswJk+OOHfMYeJ3zjWtz2JF4GBtn5IbGW9hFgYBGnZ/xBfJ6SqDhRJSf4F8AbHg5wwF2CNlUVH7sMJnF2o/McVsysnak8f2fWUYten3tccxYUtIvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991495; c=relaxed/simple;
	bh=UNLPzY8JFs3m+p/4K1jQF1/vnb71y/aulIlYtpFcVHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1yd1eKo89MX0Xu5kpRWd97eOuYUYGaoRltmoUoQ2gS2YT0EhYecKg43neG+Xsgd0ZScQxEXDHs1jU1GFty8zxY2Bg+QaTjGz6DsduSmmxCv6+ZEl4UBZApudNqT/EORwrtmWzJPTNMgMqcYq3dTmaagSbhZQkVqtQxR4mICnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=opSMYtr5; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="opSMYtr5"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c710439535so76313885a.1
        for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 06:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770991492; x=1771596292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7HcHHO+WcoSrrQ3nEIW1ykb//ECy2ZkTsyQF8ciVO4=;
        b=opSMYtr5U9pthmrYKeiGERIP/xyFxclEAcaP1OI8KLpcfOM6szpqW1coA8vMiJOFD/
         06n7VfmcaJMpILAbM6KOJyvEDw9bTfX4sItyI62UfhxXxji4MXJTYpuHkoqqyoHZBOpj
         xprpqIY6aBSZCzU3h2b5HGqCqyoIkC5LU3ijglct/+++ppA0juDNakAhPO9+n5eNDvkK
         j4EoDbcCzsOsqq99SPBdUal2kMZBoDbiDA4ot9Xi2nSZVWXnyXfp9Dm+tygZ+5TTpN0L
         99vU+OSW4W+F1rTEVhqhSaVql7UI6e1dRNL3QT4A00qcWz9kTtUC5M0ac5CE8yMJQFdd
         Zhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770991492; x=1771596292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7HcHHO+WcoSrrQ3nEIW1ykb//ECy2ZkTsyQF8ciVO4=;
        b=EPCJEOQo1mBYvs46QwxoxrJnjS3SAr8SODI5WJaw9L1G96I+UDCGVigFV5izcDsAin
         NqCDmnngtUz9fg6R+m4rS+of8iHJIWZc6vGg4kNQa6DRU5Ygqselry+4HwNQRQLhvU6n
         ivgYhXa0HMGYuepJHnycjpz8w9Zz45gC8PTju7wF58vy56K67cx6QnN+ThiSMHDLCcEa
         VJvRLSDybos6Qkuaiyn4lfNsH4UWkUBSbEtGZXkWoghTci6s2ys9df74/CjzVjOR4cJm
         YBJZcNIrVc8piKa1ZADoQGci1MGHw5cvfYUiID/vTIk2xTZUMgIBobTgmLOM2L+89oi6
         rM9Q==
X-Gm-Message-State: AOJu0YyMjHvAyvVXA/ucJIAnE7F/3zDrpjP6S8ZequlxLChr0/QVu9jq
	B8j2k94zPmMUcpz5jehFoevXJHBabqg55P96IDJ07JA8JvcHWEmPt/BS26ty3RYp1cE=
X-Gm-Gg: AZuq6aLDNFfFjgAXcyj5wPfmynmU1JGjezcLNW+eHreQVRJLbLM8DCAF+J4iKTLCyiL
	weReNiDTX/IONLwLG4CSUR48sBIQapX+0VAhG80MY/mppKZCh8ms9SHxO8JLQ2ZgB16TdPjRKUs
	q35FJxg+xoPsbN8exy2w/m3R9xYe9adzFvMCsDxbOf7X0YAK7B6SoRd2LNHkTgeMUkMHfNtGkrm
	J5sOHiHKqKbEwZVV32LaZipy7nRcrRTCtp2LAx2LSVHcZYQaDw7BACnOCR6liYkKdpncg9kDKh9
	3tXQOcqLNTy4nsrrKLM5T5z6dCT3Kf2JjV413kinshUaS4+4hUsscAUkWCQUk9lauGoLCzW1R0S
	w1ciYJK4hSPwNHyihJJ0fkbcj1TKjMIBs3FMxdQGlyz3oNgYvJTXwkWNKVBT3jxtvtUxG913eC2
	N5oY027kc82rPtNI0WOGaaC5CJlGpUV/NCT7JUQN5YNr+WscdjmMymSCbrRNuXd81SXcG/rRRAi
	bAqQAhKqQ==
X-Received: by 2002:a05:622a:204:b0:4f1:ac12:b01c with SMTP id d75a77b69052e-506a825a264mr22509531cf.3.1770991491488;
        Fri, 13 Feb 2026 06:04:51 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684b94e9fsm60689721cf.24.2026.02.13.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 06:04:50 -0800 (PST)
Date: Fri, 13 Feb 2026 09:04:47 -0500
From: Gregory Price <gourry@gourry.net>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
	Tomasz Wolski <tomasz.wolski@fujitsu.com>
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Message-ID: <aY8vf75vVQ-poVBN@gourry-fedora-PF4VCD3F>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>

On Tue, Feb 10, 2026 at 06:44:52AM +0000, Smita Koralahalli wrote:
> This series aims to address long-standing conflicts between HMEM and
> CXL when handling Soft Reserved memory ranges.
> 
> Reworked from Dan's patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d
>

Link is broken: bad commit reference
