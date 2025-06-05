Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECEA1F4179
	for <linux-cxl@vger.kernel.org>; Thu,  5 Jun 2025 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749125361; cv=none; b=Bb6f9/sLTmrHIwGmT1jWdZGHGsRpBoupZmYg7zgFWGZzkEwhRRQrO/xwuN4xPUyuRd5jXny1tsURm4xiyz/X/+aABsbiVd56O0842ENRKchdm6moyR1oTunDOoisMFONsbDtWmghLapttcVfMo1SX8f3aQRatt81r29O1XzX7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749125361; c=relaxed/simple;
	bh=68ST4wWru6aYFudYB/AR3+klXokvG7WPyNYVacGmxco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbhSqqohQsUIQu7/iBdxUmwia8ps++LWIgDx+6AwoiCftjQ/c6vLs59znzMMmlcLPKCCt9c+T1sKzB1iBKyYD8gnsSTP6K6t6vTN2Ni7W0mmWHKgd2utftjYWb1Zrw7SoZ66abRC9+OTwAmFjcQjMhShlOW0pAt2WbvrwCxSh7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NpQR+gtp; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NpQR+gtp"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so9608616d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 05 Jun 2025 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1749125358; x=1749730158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNA1AqJPiuiUBzCeRC8bK1nu38f0qCHlYuwt9uDWl+g=;
        b=NpQR+gtppXuMo0hV1L7CAZGnYnsVQaZNO5M6y6HawtmjTK0v3iAGAXwZywdfqrz6LF
         1/c0DW4a9ebx8K4t9JRpPBgZJnMZtuFSf7BRSStrgEb3jmmgZwKIteDwFogAuCa0Pyco
         M7wtRjcL78/eI8R3CXMTZV51zHPBKIXD4b+tbC8VcpVKE2SX4c4vAQdSImWZ6uusZ/fy
         wJJq2tpyGqzI85cI2ugoKjCf2KXPqtEwrXIKZNl1VVbYXChIgyBURXyrs0Us6wVJmPh3
         DWdfDbFvCHi0/gsl5Mc2462jMNtjT07w6R1/9ERGk3bjn2a9J1Z0aLg+ApCbE94W0gxr
         UU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749125358; x=1749730158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNA1AqJPiuiUBzCeRC8bK1nu38f0qCHlYuwt9uDWl+g=;
        b=Eaw7GZ7/6Yu41KduxVf2estE7OUKRGWr88GMizn6vchTea6k//JyfUeOjkF+DLUqtw
         Q6eYtRSFc7DlD+i7/nl9/dAosjxOWbyRZLezQ+2pELwQUc2QUlhc84rFh8OSmdXIpEQl
         FPlcDB+8IOs1UcT+sRb8MWwzaRBCEa6efxyASo72UsOW025JzlLa+Fu7js2wTjyz1IkT
         kwvPg/F/+Z22Q8H8mgcQxq9l9Q1OSgO9aEQsXlM+xG31PPa4IeRsi1BEtTydzEkuIIBQ
         6hPuLH2xE2m28Qd0qYD/rGtJTXHMW9wFWmxeTur7qXKhQhY4vE/e7ZVgISumsF3KHjZ+
         W9ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZYsTm6YTiSh8d6lwLmsLAd0qOQxbrVPQK/1/O5swNK1HD2LRLmUita12w6wypDLlwENwbJYiEQTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVYu58bU3n58qi3sab8W8bn9lhSTBhAvahx0abFHUVX1gIo+P3
	IY5RKrT4FL94B6TZTZ5TtW5ovF9oTRGSrUFBahHVesS9vyV3Mb800+ajNxqxcLzu9uQ=
X-Gm-Gg: ASbGncuLb442RtpBmEn/pCI+OcvTAaLo6mCc9i/OoDhUcWbimbRC7pARfwR6ZjHAMw9
	Q2YGBQnamBG/M5XUeOWUlrp680n/sCrkq81/16ixhSXjYg27G94HKUPcdYJjQ9EQI4bGrR7aez5
	ubeNvKatVmZWr72ZDH5Hg27tiqLxa0e2JsetmfNGqBeT34BU0Z6YOAoTW03aFGSwLTGUif1D1S9
	5+e86voTfOC4p5RMX8DadydG0D6aXiFFdaIudt9/qS08K390Tuhc7nxCaGGoo9hQRMHVp9Nb25K
	vaEIaIZA2noF2w0TmEifLw6JRv/CWuH/ZUDKiNOReUCFujXWRyu2gK0yw0N0FPqetzWpYZ9r7Xu
	kUL8aTDMVv6jFAXp3F7gc6R1qZlk=
X-Google-Smtp-Source: AGHT+IGoKm/5U4/UM2uM64qO2HBitYJapsKbuDFJlmk9byEyE/W8ROsmev/IR9V9jeal6LfHAI1O8g==
X-Received: by 2002:a05:6214:224d:b0:6fa:c512:c401 with SMTP id 6a1803df08f44-6faf70163f2mr115317766d6.37.1749125350351;
        Thu, 05 Jun 2025 05:09:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d4c7d8sm120604836d6.36.2025.06.05.05.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 05:09:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uN9PB-00000000EdT-18gz;
	Thu, 05 Jun 2025 09:09:09 -0300
Date: Thu, 5 Jun 2025 09:09:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	gerald.schaefer@linux.ibm.com, willy@infradead.org,
	david@redhat.com, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com, hch@lst.de, zhang.lyra@gmail.com,
	debug@rivosinc.com, bjorn@kernel.org, balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org, John@groves.net
Subject: Re: [PATCH 07/12] mm: Remove redundant pXd_devmap calls
Message-ID: <20250605120909.GA44681@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>
 <6841026c50e57_249110022@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6841026c50e57_249110022@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Jun 04, 2025 at 07:35:24PM -0700, Dan Williams wrote:

> If all dax pages are special, then vm_normal_page() should never find
> them and gup should fail.
> 
> ...oh, but vm_normal_page_p[mu]d() is not used in the gup path, and
> 'special' is not set in the pte path.

That seems really suboptimal?? Why would pmd and pte be different?

> I think for any p[mu]d where p[mu]d_page() is ok to use should never set
> 'special', right?

There should be dedicated functions for installing pages and PFNs,
only the PFN one would set the special bit.

And certainly your tests *should* be failing as special entries should
never ever be converted to struct page.

Jason
