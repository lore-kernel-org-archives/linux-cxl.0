Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459736;
	b=KJQE7mURaXZS5u8TQyk5MYRH8Fuyf9FntqnavjLgYWTxtw5wMVjvXiM5uuF4iDReOSvW
	 qYyGoTnSGVVkjJd3pjllIVIISj9idfgcb8ETppUtjAyf2jjEhC92Qetl7KrPZNyW2Sroe
	 JpbownfODTgG+TePIIfoBlgXtAxA9+mETcZ5+SWFEF4C6Ltil8lsz5R7/yRLoc1GkZ+V5
	 ZDNIuL48HXNjTl0qp+uHORyEqylU8CUP6KNhccMdQWPDO9kw5roL+h85xev0gZ4TAM3s0
	 5Hklp5SZg+scEP/qbKzdawWEKHtLA3uRR6AV0ooRmn15wDYuFBntEDzLGe1M7dI0JNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459736;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lApn+qH0ifsM8/ND3hwj0HHw3g7c62CYIJ5R9/hQPoM=;
	b=KxIVojJR1gyCWk3qnZbTb4wLraf1L2sqv9tu3Iy8OWrEwpBfHeKhYQZjRyIrQXsR9KWC
	 zFO58RjEkZGJZTra5zA097k+E0AWhgrA/vFKcMFYnfo7T3pM9Meab1F47MNzjvOCJihnU
	 NhISSsOTgnZaowuK5E4kAxOIaR/DOzpkume+mXFYmGWrJ2o/W5pUvWQ0a3y7/5gzx8+/i
	 vkDqgf8MHV4LjgjqN8V8mLu3QPRagBqsYYrel3ly/GIrtR/Hlj5hlVAtno78yhGZk9NZJ
	 ais4082jeGPFsoTWpyCvCAJY/1mBZ1bwcW/lmJ4O0ezt+2OA0ivHTzo5/MjbgAeEWLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IUBsGf7s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2150606A31B
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IUBsGf7s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1BA1F000C4;
	Tue, 20 Oct 2026 01:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459735;
	bh=lApn+qH0ifsM8/ND3hwj0HHw3g7c62CYIJ5R9/hQPoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IUBsGf7sUTg6Ycw5Hr4vELwxqFeGPRmCg/toQGZ1koGoKlU66Rb69sdIx8IsJfzOE
	 xNHZ7gnbk4Pnn+5XCQOGrC6ZglomMV39DtybXsY/Uhzvp3CLlgEfw9t9Btk+14uuVA
	 NrdKWbkWHqosI5tgyOAi/Qcr+R2YsvyBSd3cKXo1BKxY2H25g/g6zcHji778GkEbtF
	 RepXlXxN4oZfQ21YkaKfqkMPfjdjyCc/ofepGkRjAw9Kl/KXLX3nndIJY3G13a9yak
	 p4qrxQ6IoY/Xav2TNWZtugJe8gzi59zKglTIGnwdzscxbucCu9iRfqP/75ihkAQJIV
	 Tkg++IZAksrhw==
Date: Tue, 20 Oct 2026 02:28:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, vishal.l.verma@intel.com,
 iweiny@kernel.org, ming.li@zohomail.com, icheng@nvidia.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 9/9] cxl/region: Factor out
 cxl_switch_port_add_target()
Message-ID: <20261020022847.38e31643@jic23-hlaptop>
In-Reply-To: <c9206012afa920281f0145554a13b555cf835fd5.1792263750.git.alison.schofield@intel.com>
References: <cover.1792263750.git.alison.schofield@intel.com>
	<c9206012afa920281f0145554a13b555cf835fd5.1792263750.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 12:28:55 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> cxl_switch_port_setup_targets() adds an endpoint's downstream port to a
> port's decoder target list. For an auto region it checks that the decoder
> already targets that downstream port at the next position. For a user
> created region it programs the downstream port at that position. That step
> is open coded.
> 
> Move that step to a new helper, cxl_switch_port_add_target(). The helper
> takes the switch decoder whose target list it updates, which makes the
> scope explicit.
> 
> No functional change.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Nice series.

J
