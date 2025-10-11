Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8941F3FEC
	for <linux-cxl@vger.kernel.org>; Sat, 11 Oct 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760192881; cv=none; b=WosbFkYgVefegnAPgLgUOQYiZKmIPc1qXOTqW8gYlu28hoJDSuf2ZLAcqwWfNtTmG6KrHt4PHzk1Y7IoJyU0Trd1MRS/wMXyoTw0m6eMQcLh4DJgiZdcJogDV6K315NrEtzQc/Lr1jSn58pl0F/mV5ZE12FiLXkWWylO3Tn8Szo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760192881; c=relaxed/simple;
	bh=MmCJfQJOC75LNxml2KOa/YrHXnvLhKnYkjgtbFXe6rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXlW1rXVTwEVSmkQgs4A9+k4FcNY/CSTBVAjrqePXl2JaW9V+/W9jJITusKLdCHcmgt4dWYtGI7pnILmusQWeCPSWTPwgkl0/UCMe72KbxWzkNltd9cy7qvk+k1696EzMS1qV5O9CPG8cYZjhCqPGHXFQ+yEorvodf7fFZ8HGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UTY9tGMN; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UTY9tGMN"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7e3148a8928so32159416d6.2
        for <linux-cxl@vger.kernel.org>; Sat, 11 Oct 2025 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760192878; x=1760797678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kkjabnLI7P2o+VS5DvP1AuwwzOtv+3rhZmZv4ksmrIo=;
        b=UTY9tGMNodywq1JRHrCSfPiB6IlS2KFP4UJHTYqzfgFyF8ev+AYTB4M7h5cp6b0nSE
         wpJzV1a9U09GCBJ+Am5lfokdJihBUAnzeFeKBnuTPNnCzPGjB7X1hcnNA3wWuC+lCWUm
         nmf4TDxqaGFw+mJ0zE+4i+GLtY5vIwr7TrzIWCMaGP6pa/dcq5UOLehQbxfDW5RJCLXa
         kvYLoP3hCqLO5loYDBLoTG3nepo7+4rSGtSolQb99c4FPpxc/wQoqWbEgonWzwZJDpV8
         /1kPFPEYxIC8SgNbQbcnZ7D9xu8JkjPDjUX2ppN6Q3MV7cAzyshDKatLiHrpFvbVZr14
         s0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760192878; x=1760797678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkjabnLI7P2o+VS5DvP1AuwwzOtv+3rhZmZv4ksmrIo=;
        b=FLMxn/53Hj09GrRewBYQ3K05aGT+Y0+SWkxl6okkUXcOlc61IXzbIhkIP25A+jwJYU
         oPXtnyGu9RMZ3MoF7G7uujRpvz15/kM4fhlO0YhSz0N1d7F63FQwVhE5XVtg9GH9hH+S
         BcaJxM+uNBBgZBz9rmNHDOUU/GOH9KFNUPaMqXcqAIREia/q1dYJ5qC63+ep+i/6My6q
         Ms8tpkdZfT6+35nbty/YRncGoI3YogFL8opyr3B+QU9vrEEM4MolnH4dM1yowIcbX3kV
         pa5sQqbyge0Rn30443WMN57u8+8edzXet62qmWAPiVJadVcciQ0FfbzlKpr0BHfA/sbT
         S22A==
X-Gm-Message-State: AOJu0Yzk9kNj6dlW/f8OT2q4mzXdIoFjrWPweku5vx7dZNQbIMpSo2gz
	m5ARKgNCo21YtuqCCpdtIe0MamAzD9ecJsBWETGNFfhnrOhd0q064Vr3tMNLFgZpzSg=
X-Gm-Gg: ASbGnctygXlBB2+UU8dje13+s2TwivPuinbQMU91RNOJXjT4N+BnHvhSZUHzERLvFz5
	kume3PNib9Pdd6N7b+LhJgFQ2/TUn5xixJK5nSgCTMi80dQnZoOJvxExKZUhXfef/AdBEzZwK2i
	yqxGPJHX6kkfk/sRLSpWVsQpsIlp/c+dqVtMsdK9dpCIdooTVdpdhbaUsEF0IK3KN/b+skRAzUZ
	Mt1mYoeFydOGWRClCaKQZuWeZa60OuuotSTmaU1pcJQy2XzoFfLjNV4G0dEGf4cN2Lc3iG2hFvb
	Y3rSzQeEGJ2Ya/BCiKEq9wGcrkJRy4evXuOH4kQy5w9hwgII/juHnDPmiCigN++F18D/Gf8afkw
	IRXbPGcj2aK9ENG2+oKJsJdpFvsBwKR+6OETIxw8uY9FslMqQaKfxq8ir4rVrPf5WlNkxKxG0kE
	1kr36isjwYD1Ia76QckN0DXQSLFl6wsnq/JcI=
X-Google-Smtp-Source: AGHT+IGYGsolHj7MbCqwU+e0mEgAJmbILStKlyWPpyf9PQwfcudSLz5DOFNWGeksMqI6mNpJpvnJMw==
X-Received: by 2002:a05:6214:3014:b0:875:e7f:ecf9 with SMTP id 6a1803df08f44-87b2ef6c74cmr197944306d6.32.1760192878401;
        Sat, 11 Oct 2025 07:27:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc3570c1esm35438276d6.40.2025.10.11.07.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 07:27:57 -0700 (PDT)
Date: Sat, 11 Oct 2025 10:27:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, stable@kernel.org
Subject: Re: [PATCH 1/3] cxl/acpi: Fix setup of memory resource in
 cxl_acpi_set_cache_size()
Message-ID: <aOppbLQejywyZlAj@gourry-fedora-PF4VCD3F>
References: <20251010205755.205280-1-dave.jiang@intel.com>
 <20251010205755.205280-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010205755.205280-2-dave.jiang@intel.com>

On Fri, Oct 10, 2025 at 01:57:53PM -0700, Dave Jiang wrote:
> In order to compare the resource against the HMAT memory target,
> the resource needs to be memory type. Change the DEFINE_RES()
> macro to DEFINE_RES_MEM() in order to set the correct resource type.
> This causes a regression for platforms with the extended linear cache
> enabled as the comparison always fails and the cache size is not set.
> User visible impact is that when 'cxl list' is issued, a CXL region
> with extended linear cache support will only report half the size
> of the actual size. And this also breaks MCE reporting of the memory
> region due to incorrect offset calculation for the memory.
> 
> Fixes: 12b3d697c812 ("cxl: Remove core/acpi.c and cxl core dependency on ACPI")
> Cc: stable@kernel.org
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
