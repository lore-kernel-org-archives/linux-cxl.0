Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0097B2DC348;
	Thu, 15 Jan 2026 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464302; cv=none; b=lLZzETaU6lPUyNeH5M0rURU02ruX1UAg079P0wbLPrVdq3J5YTQWrkAQURqVI3m3UiVlXlOBxPaYMPldyrtmHS/A5TwLjPj/Vi+5xHnnq2DKYKQIBkLvk/Ohj45EwyCTIDKgYhfhvS44pijDEARd4oft6a4IlGh1fZKckOsXOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464302; c=relaxed/simple;
	bh=od2rd82ouiZndz+O792AU1bJlRuOu5kwm67eu1bqq4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQG74B4rlxwuuzKzWIfnsHjYod1uIcuuMcafBC9WX+N3T6AMPoq15eEfA5FJe17O8UC4saFPh+1vDjaPsfVdCyQotZq/FT1zWDCeXrSk/81LGjan3rJqppazR0q7XZ50yCtD/6NIeSh/Sme2SGlqTWgWj1Fv5f9Gn/9wkRdJDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iy+aLfiF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iy+aLfiF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UPrRGKafPoQQzqmNMl3gxMWtwk813Bg3iRWwC0yRc6o=; b=iy+aLfiFySrnJXk4mBzs+eS+kq
	Ajh4xsRGc5GsrKmLxjVN+jKI5HVC4r+Jou2yzFIUUVlM1XQfrh8WIC7fKrkH7UW+udS1WjTTBHLP+
	KxK/FmocGajHVjKgfVUGN7t+iVaHmMGAf7foAShqn3Xqye1OQLmYzfoCRA8SBgUy83UF4a8dExhmT
	cjKkykNmywYg59JXjUu9Bn4YJymn/jNrKS7KudnfDJd5VeFHyDPpa9AR6cecKn+BfzwsCSAbhvY2N
	zGnbWxtIN2bdRyRTQ+ZC0y+1aPEy50wZSUK4JFNK/FMoiHPYt4DIBk29QHpqk4rPc2fxqLMxLvJ0N
	ErHEeGDA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgILW-00000006H0T-0WCD;
	Thu, 15 Jan 2026 08:04:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 819933005E5; Thu, 15 Jan 2026 09:04:44 +0100 (CET)
Date: Thu, 15 Jan 2026 09:04:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <20260115080444.GD830755@noisy.programming.kicks-ass.net>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-11-rrichter@amd.com>
 <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
 <aWehZwXsK1IXRNU2@rric.localdomain>
 <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114180859.00004623@huawei.com>

On Wed, Jan 14, 2026 at 06:08:59PM +0000, Jonathan Cameron wrote:

> Do we have a potential issue wrt to merging this as it stands and improving
> on it later?  i.e. Is this a blocking issue for this patch set?

Well, why do you *have* to use PRMT at all? And this is a serious
question; PRMT is basically injecting unaudited magic code into the
kernel, and that is a security risk.

Worse, in order to run this shit, we have to lower or disable various
security measures.

If I had my way, we would WARN and TAINT the kernel whenever such
garbage got used.
