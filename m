Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3721B1E0DE2
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744238944; cv=none; b=pW4mnYeiuYv/v+AqFJJkelvs2yX2IBwIKLnESFDXNjfdmpBUFmryCKeIwucCN+fODj5DaMpF6fxj7NICJRa7EUq+inTzvfNmTE6niYPmsmsRlt8aQQK50SftEMMYeiAoDGjnmVS+SicrTENZiZqP0jSIKcSPUbc27O2KsBSZZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744238944; c=relaxed/simple;
	bh=9EcjlMK/aECC7Z0EsbqajEnUDd5WSMpfa5B3tFPhdFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L93l8WHuuo1hzLWwjPqEBwRzRAYQqnb7XrfLy77pso32y59AiEmG4gmX96bADCN0Y8951mkYLrnn5D/XogBvb8CxiOGb40Omm4lMRH+m0d9qWccy38W+YXdUrcLuwVW9NcvaIQDSmHP4YCPizcMl4y3YsRyBVL0ygAFSMZadleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=n/ZNJXzN; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="n/ZNJXzN"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5c815f8efso19592685a.2
        for <linux-cxl@vger.kernel.org>; Wed, 09 Apr 2025 15:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744238938; x=1744843738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/htfkjUcjTtbQhaXMacTvcz8vKgEhUM6n8QlQjKIc+g=;
        b=n/ZNJXzNImeMnsC7T2HkKc3crA7DrrwB0ADNlA2K2WBVm9jhe+3S7feWANjbM/lNeQ
         lt7MiTNVhBGOtdjuQgNbYt5/5LzoTpymgCgYyvtiXjrqN+jLKN9BKR6WO1mmeX77AGfw
         IqVpLxpoPWPIxqsYSP50i6tPGyibURq4D6ZCuJgJD4filzWp5+m69bwatxAK08180+zF
         FBwcikKT2g286CDXLsOsuOc6TWn/Xv3BoLyH2FGOH7vGRi0RkrN3wkazTF1iDpv6Ld+N
         y8OSkVnU4gNSquBYsqESbp943OdTVwE4O4fcJ16aqbm5Fwo3CZCDtZ/NnuLGgrsDepjF
         fKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744238938; x=1744843738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/htfkjUcjTtbQhaXMacTvcz8vKgEhUM6n8QlQjKIc+g=;
        b=UN+zQzq4L5Mgl/Sj6dPmnZWz/5sgaLgMvnMFokuWoJPIgEqRcto0UxIYcgwCLQ8PY9
         2FQ0xHshKZUOylE5MOevg2VRWruio6vHlY213xFy8otraf9RoOJw88iVVwT/H9Je4pzo
         DUIHwvWbfMK0yaKBtD0nCmt6QYQaTKzmJ2u81a2dBh4rLmdnBhd6dUjQNEJ61ueF0fJQ
         rcCrY2tKVZVroqpDqdwLPJizL3u1RmsH1GQk3YdqRFCOT76PpnmTkpan1ay0Tq601jIV
         DSB/4YE5CrarO9C06Sr766rEQRlmBRRjtrbaPrlBnRG/5hXeOGuydhQ/8BEHZIiRzGbY
         iiGw==
X-Gm-Message-State: AOJu0YyV8NOBrzhX8w/g+tqo34Ewk9kJ1cANWPjq9Gwvrw1/xZyQZvoq
	sYXp/S++/GTY44rqHg+rOu7G/a4y9GSiR5s3n1q1wyCcl2gKEiBOFqNqESHqizg=
X-Gm-Gg: ASbGnctGoDhcf2mSxVhup07vqjcUTVr0vgt3p1owGom1Ytc4ax5MYz+uXInEFr/eG1z
	754QYin0qb/1DrcBMsuB/qVA60bX80WKWO/1aCQKT/q7dbEFG6Dk4M/bh6ONmMwIb+dLQZC7OBo
	h+pwnLN34zjNtywmAcPgPhLM7End2RhVuJ+i494PGISWQp2S2Z1Es1cN6FTsg3Hvcc60WWV11XN
	d3K5UKAa2FXgNc3VqkXRTObUV1KZ9RQQZXfFmIA7UlIz5cERtu5W7e/shzBdFpZ/P770fXZuxCJ
	ilcPw54jTeuZ5wuXhAcoQ8KZUABaLqcJotp7Ox/p5W7XopVDFns4yw==
X-Google-Smtp-Source: AGHT+IEKFpKNfsSWwOgoi6DRSObHn0c2ff/NBOM3pXCDlmuVPinzb7ITQcqd7tkPTc6RK5Po6EYdag==
X-Received: by 2002:a05:620a:1712:b0:7c5:dfe6:222a with SMTP id af79cd13be357-7c7a81b14fbmr21927485a.42.1744238937941;
        Wed, 09 Apr 2025 15:48:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb91:e45:4a49:ba4d:3fcc:71ac:af2a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a10d0ec7sm126492885a.59.2025.04.09.15.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 15:48:57 -0700 (PDT)
Date: Wed, 9 Apr 2025 18:48:54 -0400
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] DAX: warn when kmem regions are truncated for memory
 block alignment.
Message-ID: <Z_b5VsY0S5cihYga@gourry-fedora-PF4VCD3F>
References: <20250402015920.819077-1-gourry@gourry.net>
 <Z_bzAapzjzFR3u_P@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_bzAapzjzFR3u_P@aschofie-mobl2.lan>

On Wed, Apr 09, 2025 at 03:21:53PM -0700, Alison Schofield wrote:
> Existing unit test 'daxctl-devices.sh' hits this case:
> [   52.547521] kmem dax3.0: DAX region truncated by 62.0 MiB due to alignment
> 
> Tested-by: Alison Schofield <alison.schofield@intel.com>
>

Thanks for testing, good to know there's an existing test for this

will respin w/ Jonathan's recommendations and tags.

~Gregory
