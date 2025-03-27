Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8120C46C;
	Thu, 27 Mar 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068150; cv=none; b=e4enWTqwxMpsqPBxJa40jYd5Q7Fi44yN3gQwPr76JWpNIACPnRFT4BKxyqXwSr+zhQsWx/5dm7IajWQ9wPhqv5a0kYtr4JFuQwJgUAH1asagg6Fshb9zEkfVQeaUEyKHPor/uggDRgdno7iMRuhfrPSEvdDsQoXQilDghfTcYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068150; c=relaxed/simple;
	bh=emluPB/+HEfLfthucSGOJgpzoeP68z4bxCiL6U9VHEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMycQxcbHTg/dkkzzNtDys90jfyMZu0RG3ORPXvDgWTAuPdmrdia5XAR110zT2SJQy2YlZvnfkmIDh89AUNWhFzP0IeLCZCN/UUVrz0ooVsYeQ1GAt+YRzUyV9TUC7vy3kd0ODIoCgSVqJ1WoViPz5NntfhRz6kDlrr6mZ/4YCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAHDqbSG+VnAJebDg--.1646S2;
	Thu, 27 Mar 2025 17:35:14 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwA3PorQG+VnhkxXAA--.797S2;
	Thu, 27 Mar 2025 17:35:12 +0800 (CST)
Date: Thu, 27 Mar 2025 17:34:54 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregory Price <gourry@gourry.net>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z+Ubvvrj9DovVs71@phytium.com.cn>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <20250313165539.000001f4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313165539.000001f4@huawei.com>
X-CM-TRANSID:AQAAfwA3PorQG+VnhkxXAA--.797S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQACAWfkXV4FHAAHsc
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWruFWDtrWfWF13GrW8uw4rKrg_yoWDtFc_ur
	s5Cw1kG3ykWF1Igan7Krs7trWfCa48Cr4xuaySqFnIk345JrZ5GaykAr95Kw45GFsFyryD
	Cr10qw1S9wnI9jkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

On Thu, Mar 13, 2025 at 04:55:39PM +0000, Jonathan Cameron wrote:
> > 
> > Basically, the heuristic is as follows:
> > 1) Add one NUMA node per Proximity Domain described in SRAT
> 
>     if it contains, memory, CPU or generic initiator. 

In the future, srat.c would add one seperate NUMA node for each
Generic Port in SRAT.

System firmware should know the performance characteristics between
CPU/GI to the GP, and the static HMAT should include this coordinate.

Is my understanding right?

Yuquan

> 
> > 2) If the SRAT describes all memory described by all CFMWS
> >    - do not create nodes for CFMWS
> > 3) If SRAT does not describe all memory described by CFMWS
> >    - create a node for that CFMWS
> > 
> > Generally speaking, you will see one NUMA node per Host bridge, unless
> > inter-host-bridge interleave is in use (see Section 4 - Interleave).
> 
> I just love corners: QoS concerns might mean multiple CFMWS and hence
> multiple nodes per host bridge (feel free to ignore this one - has
> anyone seen this in the wild yet?)  Similar mess for properties such
> as persistence, sharing etc.
> 
> J
> 

