Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEAD3E0082
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912917; cv=none; b=ZtLkdaH6nCyK++mwy7mPnm1UuEc628okPT6fC0NDNy4vBVu9fowYDx4qDympHYTYJBuefgb5zob+Hnd6S1nSn4AjS01kSAAk57WZ7wN18sHbcjRxLYiaxKOc1TbRFdItkiffRuUhHsNCCZLD8HfaOg1T8++yVZUJVRAxZS3WUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912917; c=relaxed/simple;
	bh=j0s7gyTm3ufVh4hsn9exlGlGMDfo05QTPV9kpf5l0bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvF7QiPyGc5plt/j6UzQrododBSwZtsRWCJmp7qp3hGJdIXCTCYWSF8T8LI/eFWFBBshcXwhWr93Z8/314zGMRZicCFlX14C1COoye/EwyoZSh8Sl5cjueQ/F1nWHyR5fW7KxjAZkKbAZfP/wXeaH1F7tbj0K7yoYMbTrrXNiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LJTwaMzi; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LJTwaMzi"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e6391b114so50042285a.3
        for <linux-cxl@vger.kernel.org>; Tue, 04 Aug 2026 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785912912; x=1786517712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MAH+HbjadZy8SK7BN06G+Jew0hakQ5psvbLZDRHuUt0=;
        b=LJTwaMziQv0IT9zuOgIxCxEX9/fejYSe4moRRnWlhhqP7VQ6oD6RBDDdEo7Sb+RzNQ
         q/qHN2SAZ90pYzjUaD1UXp/HoHWxL8V/IOpxor38kyBnKfsrlNmtyejyCc2ig2jWahwl
         1zreIB7nnm/DROK62Pf3+wDFRJBohM0n4g+OVzzvs2mKGr5k6OcIbiTnF85b4BU2dG6G
         fxT8/5hd3yJ44TPNF5CyrCZ6HISBnYhnBFEbJV3BJ3/Os1d0ZGfcO9Nqo9qmoiBiz0HS
         qb6E0uQ5BWFFNFCC0WAsVqjAtdjjIFYWoMOVGx1W5EqOiR7qOsvqJ6WSMPiag+kXld32
         Oklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785912912; x=1786517712;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MAH+HbjadZy8SK7BN06G+Jew0hakQ5psvbLZDRHuUt0=;
        b=j3KAJK2Q6mWi3MLTJWNQ8NxCBRIJ8bjCO/fVAKzOQwOWlxzxjBTp+VoSQnTL03S3m7
         aXtuJnVo7zw6E3EcYrz8FDfiwIX5ss2JOhRVj03puSw5anqco7bcjDmQnoJZRBAWznlv
         0a9uYI2fB/gUhE6JT6bMVsbYRDFCE+fJ1PFljLof5YIFwhckmUcOHHytLAaNs19Eo4St
         YhIsGEAdX19gWu6mDhpOiFyxqJ+iPM6NMIxoFowB1VuRTqjd0PIUsND19jpNJvXm+/JM
         2FtadetKAkiSguKjoadZC6NbzWT5PnDgaW5KU0yiLBXCPLFuWn8xMqNKWnZc3IxCTThF
         o/mQ==
X-Forwarded-Encrypted: i=1; AHgh+Rok3+fdjUKbXsw8caIZX17XcxmO/Cs1Zbx+iYhhImbQEVOq3DjnEIoOVFgxGwbUDVuAJWTP52i9aYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziVrYHhsQkDLktfeugCp9LFcdz5Jp1waE2Kygdf8YqqU2TAv0z
	5csTVAde6QWZcKV4nUNwSrSx70OPOJiHvXYBAuuZOrtDIkBW/Qy49ohZxrjb7NYVAxZEWQI0dx8
	ths9b
X-Gm-Gg: AR+sD11a8VDL/MCZNoTO7maQGtjJdrQcEXe4yLRHxcbWlkQin4OsMhm1GdvosEkRbh/
	8CpJP9/tbfZTU7XueGAk2of07N9EH1eoLNEupO4sfxSp6VUi28hphLWNWSArBC4e9cWMS328I1e
	pfgP/Gx0lInxtG4+OZrBsUdqh/45gT6ST69dOe7oE3AVZQQm1Bau2vy/aO815OWaCQVF1Jmq5II
	3C+WV0dPNuqpO/8rQf0Xn4nXi9MEoWpE6TNTt6nKb9EwrEG1rM6wCOLOfHZQlzheNhQ8cRjg5PP
	CuDe4Cizer0Soy6MxAZ4RXcvdpvCjt05jNcJB3y7qCtj+nMi+RdbUIvFM6tgPL0YrYpHSil3RrE
	O8B2TqqZi3z8KCly/+Rnf4M3whpx98ZhfaITArXKDhlZnP6vdhBuOzjLjS3An/k2pOD0+V8w680
	7hZ8nK6e2ESO4mPxnCT3ZeG8H1kwwGr927cWKXv7Dx5jMhIyak0K3AwWG56MurDNyr4j/7hRxdG
	he2I0rn5wehITlyrbtZTJnaj2jUi2ZWQVaQ8uKQgUa8J3AgBe/Nl5c=
X-Received: by 2002:a05:620a:a502:b0:934:a12b:1d41 with SMTP id af79cd13be357-9364926d5f7mr313415185a.33.1785912912512;
        Tue, 04 Aug 2026 23:55:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a5b5f59sm93592285a.47.2026.08.04.23.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 23:55:12 -0700 (PDT)
Date: Wed, 5 Aug 2026 02:55:10 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net, jic23@kernel.org, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org, iweiny@kernel.org, 
	ming.li@zohomail.com, rrichter@amd.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sreddym@nvidia.com, smadhavan@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com, newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com
Subject: Re: [PATCH] cxl/region: Restore passthrough decoder enable on region
 re-assembly
Message-ID: <anLd5Ln3VvDtE0Yf@gourry-fedora-PF4VCD3F>
References: <20260727103743.63343-1-icheng@nvidia.com>
 <d96567c3-df6f-4008-9678-c4fed3787309@intel.com>
 <amgQUnkQ1VjyXtzx@MWDK4CY14F>
 <210c8742-08db-4401-80eb-9ad9a8c14054@intel.com>
 <anLVILs6MNR2lx5i@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anLVILs6MNR2lx5i@MWDK4CY14F>

On Wed, Aug 05, 2026 at 02:21:05PM +0800, Richard Cheng wrote:
> On Tue, Jul 28, 2026 at 07:25:09AM +0800, Dave Jiang wrote:
> 
> So I re-tested those operations on v7.0-rc2 kernel without the patch, we find out
> 
> 0a70b7cd397e ("cxl: Test CXL_DECODER_F_LOCK as a bitmask")
> 
> This patch is not needed, and Gregory is right that intermediate decoders should stay locked and
> not have F_ENABLE cleared on teardown.
> 

Makes sense to me, it will look a little funky but auto decoders already
got that funk all over them so it is what it is.  :]

~Gregory
