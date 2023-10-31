Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C246D22
	for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s5Yr/xdS"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A1C9;
	Mon, 30 Oct 2023 22:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+9mvGdCWRziwRBlUvLpIBIs9buwYvmhv/N6u3r2ZS0Y=; b=s5Yr/xdSP8qucbLVnS0k+DtJhm
	cwiBGl5YRIx3fIobgvRJFVv0uUp1Zz127Dzencsn/5huxdopm83kJWQnprMX3SPcrwo7oUJRFZYHz
	SJMhQjgzYhyNKXHYB4dGZ8AuD66Cr/loJ2lG9aeSe5lWxadEl0sFwChzyhLDMusAQ+cQ038FgL6ZN
	Ld5VFTlaJNY20thm6hn5A43aUlsgyDEPOf/Ah3WStoqMY6EsC+GAjI0n7ldc/NLFM+5fMkUfi/2s3
	i7v4KhTSbCbwz1kw+t154M72JgxWE/Ixc3DSFLagVlL/u6gDztI5iRfDVXESGtJPvB+7FzNSL211h
	+eIRnVVw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qxgvb-004YAm-0e;
	Tue, 31 Oct 2023 05:04:35 +0000
Message-ID: <dc312544-6070-4299-b9ee-903b34d7cf21@infradead.org>
Date: Mon, 30 Oct 2023 22:04:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Oct 30 [drivers/cxl/core/cxl_core.ko]
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20231030163344.5a39a625@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231030163344.5a39a625@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/23 22:33, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any material not destined to be merged before v6.7-rc1
> into your linux-next included branches until after v6.7-rc1 has been
> released.
> 
> Changes since 20231027:
> 

when CONFIG_ACPI is not set (on various ARCH):

ERROR: modpost: "pci_print_aer" [drivers/cxl/core/cxl_core.ko] undefined!


Already fixed?

thanks.
-- 
~Randy
