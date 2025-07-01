Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3526E6EC;
	Tue,  1 Jul 2025 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371498; cv=none; b=npREMXSn7jTGeAFLQ1J29c+rZjauIBFgsF2+HLyr7jKO4jrMwRC/PmzPsSwKqzFYsxq6cq5H/0YCE7erhRvUqfQo/1B70aG5Pgw8cjFRwxXR4Qq7lfWVXW5ch6pQdSt68qr9LEkmUkEgJVrKPUgr5vqLw33VSZ7ADQKZUtVl+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371498; c=relaxed/simple;
	bh=c2Bmq3jZSa4vMcCaZHenvzXCq4Qy2qHJxMcakheGwJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjoeTCB5063MomIOCeaAf/q8/h4pW9ZrXedLvN3MiF088pcxm+1/MHARCjopWOgohd7Ju0KG0VOoaxvj+Dacdxe4P0f9lawVYK9a9DYe8sLFsEzWpeZoEvelDd1adN3T81TLRus69zPkFGE+p8Bwdhe380Rg/NSMJjf6enTPCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tb70dUxs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tb70dUxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C20AC4CEEE;
	Tue,  1 Jul 2025 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751371498;
	bh=c2Bmq3jZSa4vMcCaZHenvzXCq4Qy2qHJxMcakheGwJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tb70dUxsWBEXE+K3Z09akprf/W5zq3wmeuOzTjINY2oBCthco8PNLvf3wg0FixFRW
	 2O+OmOBOr5/HUXoq2SwfCA90IcgnLCClAX5q3IeByLlcWc9fV7InH8yyoQVBAq1Uaj
	 a8wPO9V5o+1/RzOKd8iEU6eUFbH3WWYbRadKgTfA=
Date: Tue, 1 Jul 2025 14:04:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: make cdx_bus_type constant
Message-ID: <2025070144-wife-commodore-6547@gregkh>
References: <2025070112-whoops-grove-c355@gregkh>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025070112-whoops-grove-c355@gregkh>

On Tue, Jul 01, 2025 at 01:53:13PM +0200, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the cxl_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.

Ugh, got the subject wrong, let me go fix up...
