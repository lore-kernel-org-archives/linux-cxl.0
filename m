Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4743C1F31
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982707; cv=none; b=FsiTpEFbT86symasNe3ALVWTP0Fu9Xr34bFUka6Kdk85fxxkMBo6ZwH1x1Xy689U+8UjoulRDOQkxMTRJvkYOxzp4K3xQFhvdzpUKvYGrTl9zYLoMW8SnJYKqNRVZ9Usw9mslNNSlXqvGgxVQQiXtYnTfdF1qfnTR0vZFyefZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982707; c=relaxed/simple;
	bh=vDtaNZzH3e2xlpfsoFlVhNv2EQM9QV0i5Pm5ZX+bGHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geEuwiVFJ8CvAvZ+Yr2I4i8NOq/y7U3SEWooWEyT267qBCoXZU/Dwl3HV0xu2t/hNcvTNkwwrrrF2SwHTYBTAgj5559VoeQ8ZHv626aTwPq07/STnidkDHc+ORqV0yFtktP4nWLcT57F59R1XGFq062HJuMR6NRXWinkY2I+VUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNSmwjeA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNSmwjeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84E81F0089B;
	Wed,  9 Sep 2026 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788982702;
	bh=EoXRzroIS0rYBAXc7OVVvsZtKJ5lbhA5JY3K+BeAsgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eNSmwjeAfYx3P3qa5WD9b8Qg3ICMSQdGFIiOJXXptNwlg6uBnH9QN8ACTyd4Qw3Ai
	 h5Z6HyfSQGjwDTXN59PpKUGVPj5k7iz0PNtW4XQAMerCO/12FIr3TznPWm9lR2eBUL
	 wtZrtU9NyHjwBJulSogebUDDd71JzaVH8l4QtuE1Zfi24pmLW+XKmGnIl44kOejgXY
	 sPM08sGgvdIhNwLnaA1nq8UtI8/LO0gROzCljwASX5nSX7jy2zPJ+y0SuWwN73WD6H
	 Z3MAa6gCQy5R90GtF+5Q7v7ars6z2PoeeaWmsmUTnvg0qbgGMhdoasgfiYBlBP0MdV
	 EIP6eSeF/yWvA==
Date: Wed, 9 Sep 2026 20:38:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 01/10] cxl: Add BI register probing and port
 initialization
Message-ID: <20260909203815.61d8fc5d@jic23-hlaptop>
In-Reply-To: <20260909170302.1550680-2-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
	<20260909170302.1550680-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 10:02:53 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add register probing for BI Route Table and BI Decoder capability
> structures in cxl_probe_component_regs(), and helpers to map them.
> 
> cxl_dport_map_bi() maps the BI Decoder of a downstream port (root
> port or switch DSP) at dport-creation time via cxl_port_add_dport();
> devm_cxl_port_bi_setup() maps a port's own BI capability during port
> probe when the upstream link is in 256B Flit operation -- BI Decoder
> for an endpoint, BI RT for a switch USP.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

