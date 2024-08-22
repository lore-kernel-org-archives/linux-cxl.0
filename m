Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A4125AC;
	Thu, 22 Aug 2024 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724362174; cv=none; b=CFSsA26FjWXrdgWGmBq/RiX7PfiIH5Zgy/aa1JZNUSXgHwgNobe1s3m02UMXg5jI0V6Qtypu0e0GA2LT1/EMrp09FQ4EqEU3XcwUqOCXIFs3V9vJ8frFLJbH+Uu19ZwZF0EYSihD8nwM9nRfHpEyUog4FRRe3EAifl++cDZDXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724362174; c=relaxed/simple;
	bh=xMTzioUU69fSeiehyTFOgtMCU/xWQtU5V5C7ndXts7U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EVoEr2c0m3onWHE4ObHiWGXOy7PDgyEG4DS1DPaR4M7TxSFJblzT+i3mtKeM5m5s7v0OZOuEaHgaHl8hIHXLebA6f4gL+K4AQ6SfVlg2yQ/X9DnDuMST7tYio3YQ3CpMaUbaoNEmeB218MQ1egw0J7aoqIbQ+UTTE+29zMOhNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1zM2qBK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1zM2qBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D89C4AF0B;
	Thu, 22 Aug 2024 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724362174;
	bh=xMTzioUU69fSeiehyTFOgtMCU/xWQtU5V5C7ndXts7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S1zM2qBKrKDtenxWPdkQ6IMrycPjm5PCXJuHlZuxEib6+PakZuCwTvsmhaEevBtg9
	 1yIUJqslh03psF8syGCt8idGW7V65tuRh1wnoMx223ckqMLCZ2da7TI/+Cus0DZbK2
	 95q5P2+GzxCQSOGx8/wNAUqsqNsYi1RJ+onoWseuQ6YkyGlNEJg8oEI+fsmcsqki1U
	 BUqZ2DQNFyBF2BRMrWbWx3+UoQ3+q+Ey8s7k+LHQKWb5IReyTzVVEenHszb9Qvd/bS
	 Smxnx0bNkzkOZAC2E5tthcLwTQkQ/iO5dHP8tbOD/lUx2xKNi3lNbRZRRmpcZUp6aS
	 Ap1oZpTIZW5dg==
Date: Thu, 22 Aug 2024 16:29:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Huang Ying <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <20240822212932.GA351096@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c697cf7b95a_760529414@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Wed, Aug 21, 2024 at 06:43:43PM -0700, Dan Williams wrote:
> Hi Bjorn,
> 
> Ying is out for the next week or so, so I will address your comments and
> resubmit as I think this is a potentially urgent fix.

Sounds good, thanks.

Bjorn
