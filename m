Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23A7A13A
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753058559; cv=none; b=s5sHjzG9/UaNKjmNyXMxVQU9r+9TG4ra9q+2AtVCRclKQOKwRVW832MbYKE8ChkBUX3xLVr3uNcAmDVjN4O3ua4Ma3XICWkiJVyHcQI4FYqnb5OcyTlbCVJTDwG99d8WFyQtEJk9QyXO3qjvl+cegpG1i1m4fJsL+XVhnuE/14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753058559; c=relaxed/simple;
	bh=qxOrhzqyG9kCjTWQu+y6SKTJcaE8DX9D+ByMeTUpNHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHML7q0A+CNlpcte7vRikKZ6/b95K9tNtptdKavkUp9CZFuBeYsu/mKNLeWI00L3VusP/iVVwAOXifnSJDmclBqmOGUfXFdtAAgETH6tbcjVtnQHvwrT2NAkhDM1Jh0u4XUQqbW9YQgjOGUlTzVt9wGTTtSy4ib0rFWzx+ENvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m6x7ny8B; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m6x7ny8B"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab7082b3f7so51372681cf.3
        for <linux-cxl@vger.kernel.org>; Sun, 20 Jul 2025 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1753058556; x=1753663356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5plOGEMFaS45Bgu/ju0R5BnX8oJZ/qxxofN4PLKzGiU=;
        b=m6x7ny8BDJ3rc0hT3I0QAjGWmpsetk39SMaVruYVXSyk8MkUy9BkkgHKjef7f5De3h
         YFdYHPowq2S27QHuF7uoiOst2t2MBXaQzFBpRvyBJbA0bNeDlzOV6g7QpW0wAwk8REsW
         JrA++QZcPbN5GRNtMa2McNu67+8IPCowHeCDwn+2fM5Zq/EjR3lOU5aJe3Wh23pL9Ul5
         n6Tc3TFGMwH5Q9yHpxgMfYBlV2wmgs1uU62S5cxMzxlFGQZ1BuHtg6RNSGyo61oL39or
         +ymypN3uOzT2N9JGv/YDGDHpq+OsKtP8IvHxAErhGU+Nn+SqTxkNdIaRcyhif8Nt+udY
         N+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753058556; x=1753663356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5plOGEMFaS45Bgu/ju0R5BnX8oJZ/qxxofN4PLKzGiU=;
        b=SPRI3/6NAn9Rxtii/qUJWEokuHW70x3rNpyRs1mCLCJ/w82I+i6ZZv96wTRS1B+pX8
         fMNL+DsNy94+s2hJPysqYHjsJtG4XM/UOx0xoEBRqWxm6gHkFUy4z6ls0TcAJ2SooVxE
         VNP7kou03RLPLYfOFI4DDE87FpsEclJuTOWoxzNYV3lKJumnbQemLF6vvWs8mMMEPx1C
         zCUWDxR3Qjsmx6zO9Qb60i0HdfKcw2rbLHjY8rhUFr647FHyGOdtbYL3sQ56f632Vhzn
         MGFuIclVxbgd+ELaQgXx3k2hVUzm5/F5d4Lhd19dQeiVMHQzquGuSctdPKebYquQCLMC
         NnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZoToSepdUzfjvXDI/Q7FZXQ9sNVF5XUFjDICx7O/krBWBYFc9VQ+VhO3SwPOlSktuq/AdiVyfvi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5iaYyzUqED0JEuTqoO/P4OXmDJCbUBeILDZH3ukNQhB7Mjaa
	NbsgAKZsSRVWnDpNvdihjMr/c3WeWq+Nl80cDbwc3WQ8jgD1uLBUAcMhnPbNJJ88RSw=
X-Gm-Gg: ASbGnctfCLKOyPNjwQCzrFbW4zvOoUf+HJS8Pjsa3v/kxqk9dv8lffXIP5vpDv2MaGb
	wZ7/BlO6+M583IKr6uP9AuYHjYUQaUqJSAOdCqID2RL5EnUvk33TBkgYH8As77RX0G7PQ8YqQn6
	Kv7S5hsNO4gT+KVxkrqza4MQdHGqsuzvqqmotQRV5h8eqf+S5KvPSUTzIQmY8846rBAud9riB74
	NeZrjZTYcBb8JtDRRDRp+4oVgnLnu2Pb56flS5P88qcW0JblmK7zyQff9sjkB3L3JxlHM6miMiP
	g82+MBSbT9gbKUx/zZBmpC6ClN7QRMnyY217jRq38YkypTLv6OYlwXk1hLqXruhH+KI2fU5QT1I
	hhXwVyb81xfnMwpZLkUgW+PHnStXZYb8MZc8AjEYUqESl5NYehnYO023hAzXBEHUvlaAyv8eTdQ
	ncmGbFWVjVeLbg
X-Google-Smtp-Source: AGHT+IHNWco2tVVvQ1Qm5wja2fI3VWQ25WhSh/3CmATM5MOVK4gNPykPcyjoE6tfiWrecsdM+TMQUw==
X-Received: by 2002:ac8:5ad4:0:b0:4aa:d487:594b with SMTP id d75a77b69052e-4ab93d82da5mr255955661cf.35.1753058556378;
        Sun, 20 Jul 2025 17:42:36 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b47a31sm35649881cf.65.2025.07.20.17.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 17:42:35 -0700 (PDT)
Date: Sun, 20 Jul 2025 20:42:33 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>, joshua.hahnjy@gmail.com
Subject: Re: [PATCH v1 00/20] cxl: Address translation support, part 2:
 Region code rework
Message-ID: <aH2M-b2b_trVTB7L@gourry-fedora-PF4VCD3F>
References: <20250715191143.1023512-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715191143.1023512-1-rrichter@amd.com>

On Tue, Jul 15, 2025 at 09:11:23PM +0200, Robert Richter wrote:
> This series is the second part of adding support for CXL address
> translation. It adds another rework of region code to address
> implementation changes or conflicts of current address translation
> code with cxl/next, esp. the introduction of support of extended
> linear caching.
> 

Apologies in advance for delays on review and testing.  I am unavailable
until ~September.  Joshua Hahn may pick this up for testing in my
absense. I will make myself available to him for questions as needed.

+CC: Joshua

~Gregory
