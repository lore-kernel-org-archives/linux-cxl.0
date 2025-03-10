Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B579222B5B8
	for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616397; cv=none; b=euxIOa93Jzayi4pnuomYogRQaBsdLfSL7oI+IWldg9+k+HPLOzYr20fXKC3XjKgimylLGPt3w3kniaCVwl0meC5aQRzcZd/TlgKSjH9+MjjJs2j1MDTYFbEBHaXF4KF2v0/RxFYyotxFwT4OpGwd8Ai7+A5238bF5jS5NXe7KiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616397; c=relaxed/simple;
	bh=KWu8zDSYCkOIHDj4bVHZMVBK5paBYHLwqNrwSoppf4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdF35jp2C1EyyHr7PQJdWSTUxWZ/JnEJe+ubQ61s4uFMHZQZTHmUuvLLS8OX7doZBWtDXPNs8LQ2HpzXFJrEo6eunQiad5mX/8sWf6U6WFOndVe7UYIySq+vCfbhnTcK1f1zgC/pxLzk0tTu84OdUYAHm/1ZoGfoW3BCE27KChw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kwgCcwKQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kwgCcwKQ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4766631a6a4so20313891cf.2
        for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741616394; x=1742221194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFZo8zPwzqdWQJxqcj4qgZS2PvMRMOgjbkxudd5sQoM=;
        b=kwgCcwKQBSDOOnqPDxaJhqV85i9+y2dtmXgk+H6ogRzo28zdmImbeYfpKYgk1K9jm9
         GOuB02jIMQNJZuTeMNvlYpOhZ2poCRQGAqaKOv4CtZCGWia96Y2stKDUuFqes3ajvF2H
         TU19b48ATv6dAUufi8VvKxySo229qsU/Abd4Tu/wJi7zN+CQfjh7MXuAGcu/yjy0ZdSk
         CmKVG/bcvbjB38SzQ7d9XKpGmzaFFJ4wvA/tGTAOYsQul8iKCwU74Vat0WejCZPGVcpt
         j7kwiYKL9sOlqO7l/iCN75E4PRWZJOorKQYM/jfa50aZ53LG0NdJPYJ3hhYYM0IlZEeE
         Gtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616394; x=1742221194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFZo8zPwzqdWQJxqcj4qgZS2PvMRMOgjbkxudd5sQoM=;
        b=iWHVW1vkKaLmBZxkDGdTAdRym9xlLLCgzgKf1he725aImgSBt5F1JGNcNobdDtMJyH
         fcGheS3A7VqP0fMqXXdpmWNEPxjmuHx7n0HZPr+RtsPHkOL8imrNLyNY1pIfwG7LRs6T
         oSwBknE3OFOclJS3fv7/4+oqTG0+i65ZPKFIw1ibD1plR6tW73BIRv5R7ysxVhRCpKaW
         LXc3p9o7dJMahMq1YLjLHt75Hgodt4udTKEnG0tSlYgUTN4aA3NrHIDkTAquSE5vZY5N
         lWw4EAs5iYmpPmJ5Q5XwH9z3hCKfZhqqyMl+/+4QiN33HiHBKIJ72dcxcjd8+icgzxWa
         TcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCwsFJBh5lUbIWVEAAWvVIhFb8aD2J8mqqdHcIMWpy/LabQE2Mucs9jTc7V5zeTJlpKqrN5mdxgds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaPh/qgQK4HJL3fhwVudDZsyMqQwV6KkFqHKXyTwBphG/6abzY
	ynRglLh74k8DM1QFvwxjc01gF6Tu7D7i6QPLIVFQckrWOEpMI9LW1hCEJIN/99w4gizMSTuW+WW
	Q
X-Gm-Gg: ASbGnct7IaQg/iKpl+0Pvd7iP5ysYsiEUcwZgQza4ZSVOCVc+tSg6l95w3NzrKxc3iw
	wImZo8TbUctdwKYqFGqjpfzhbJ5TdXRAOIaS6AoD0pmE7Ak4vRNSPCoItRyGHbBwzPJ4+qExTKu
	5o4ZGwmyNxb1VeKuzOgwKyretezV2YenDyrvDRi2QkksbtrbgiSmmr4lYyVnWnTSN+YYfFSnqgy
	6SJIvbOVlGboLLeMKDiJKPnxQRRvVylO1t83LwY1gVh8TLcmnaGiJcp9Xyt/lnBdXe2z3KJ3a0o
	aJzGPM49/bGf7xdDTfics+vX5k4Vk0eOfsS9VBFB+hu2JGRMPa/823pe7dFRta/YrQbb3aeP4Bc
	ND9zDKdy+Zcu0nHSk3JjJhLAwCwE=
X-Google-Smtp-Source: AGHT+IGMJpR5j6TAtQib68qhOoxtIvV+O/W/i3w2HAax+rxX7rMLW1/8B437NQlpd0ajBQv1DIt3fQ==
X-Received: by 2002:ad4:5d49:0:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6e9006ba2fbmr185600916d6.45.1741616393666;
        Mon, 10 Mar 2025 07:19:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c4cbsm58904436d6.22.2025.03.10.07.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:19:53 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:19:51 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z871B9WVRaeIYuOs@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
 <Z87CuDBMeIcPIWvV@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z87CuDBMeIcPIWvV@phytium.com.cn>

On Mon, Mar 10, 2025 at 06:45:12PM +0800, Yuquan Wang wrote:
> On Tue, Feb 04, 2025 at 09:17:09PM -0500, Gregory Price wrote:
> > 
> > Platform / BIOS / EFI Configuraiton
> > ===================================
> > ---------------------------------------
> > Step 1: BIOS-time hardware programming.
> > ---------------------------------------
> > 
> > I don't want to focus on platform specifics, so really all you need
> > to know about this phase for the purpose of MM is that platforms may
> > program the CXL device heirarchy and lock the configuration.
> > 
> This question can be very naive, what's the meaning of 'MM' here?
> 

Memory Management - linux/mm

> And since I am not familiar with cxl bios configurations, based on my
> understanding of its acpi results, there are roughly two configuration
> schemes in my analysis: a) users should enter some configuration
> information manually (like region base/size). b) bios could provide a
> recommendatory configuration by device information.
> 

The BIOS must produce ACPI tables to set aside system physical memory
address space.  *How* BIOS produces these ACPI tables (CEDT + SRAT vs
CEDT only) dictates whether this configuration is static or dynamic.

The devices will provide a CDAT (coherent device attribute table) used
by BIOS to generate these ACPI tables.

All of this dictates how linux configures its NUMA topology, programs
CXL HDM decoders, and how it associates device physical memory with numa
nodes and such.

~Gregory
