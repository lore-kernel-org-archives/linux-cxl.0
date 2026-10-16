Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785CD30216D
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164516; cv=none; b=IXkI8U4ozYglfkDPj8o+IxcEQLBOnZbnuRWc88cNLde+LLpbSba+eerqoQO73HHqA78xTYef/i1DEuhZP52omV5yxkD4V9tfqC8MZVZtqgrQsQgTtPzhfiC/X6BW64T9VyBPXS/8N2h7UOs6Ob7d6m873KYACa21ZSeGCF5YVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164516; c=relaxed/simple;
	bh=45LS1UdziFdH9/L28pE18LpNfUOLryxMUFQxNA+kup4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyfRQxkaooM513WMxmgx5kQBZd8yk/6a4fsm/eW5xB+pCOhTwW0GcwseUE4Q2JdXfEzo2YQ63UlOte/hQINW0ngFgiru/bOJDl9CbwiP9LqaCN+B1I946pQx8eUtSEBzTdcPx8cPm18mEzaHl2hcinUZ4SCyCXXxGiKd5Is85zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CKlng73v; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CKlng73v"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5339199d8c3so221001cf.0
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 08:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792164514; x=1792769314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P2YR4vuawodUu/XM3aGdAaeSVvyprcEIWQFxlPCqAas=;
        b=CKlng73vYaOuWSTK0SjYYKzbDBx7cVk8tvVSDmP4NliGT2foQCJ1bhxBANzLAXgr3R
         NHTgdvoe+egsyaAyM/W2RWUe5XN2GZq/D+4jDanilyxXiyjAhU3WlUW6YfjxbayBg0//
         qpG1qlBEwqJJdFmdK8R4wEy7HNLv5D5/JSRDCU+Ve9v2EKRf5bepqesG6n1xbiq8/Uwf
         E4/LIm/He2vUj7KcIzkLAGyhEGoxHv4s21HPRLOPZTbPlsBePWVJVdqncBNz2Cv6wNOD
         rP4NiiCedfKQjK3d6stLPwO++ZMzviU49B4Q8z7utIugQTnkLkliGhl4aXX4PaaqWge5
         MkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792164514; x=1792769314;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2YR4vuawodUu/XM3aGdAaeSVvyprcEIWQFxlPCqAas=;
        b=H76d0Qi1tsa8RqpuDcnI+p7w/WCkxmc+OxEzljVPputbVgJId3Ai/YJrYnmnMIwX2j
         JXAmFHecmQ9FU54D0pTDAzhWSvU80SNFHDPgg21vaxvSIklM3SOvtj+MMIKfvywwwHVU
         IXDclIwzFAMP3L0C9f0hVHQfql49DY2yQiyZlaZbpbMsr/9CNeMR2njV3uX08APaSMA8
         qM45kd8Hz/Y4/c5tyZMr99lWflbE7ygSt7m8eOSKS97Wg0nkhka1vOMpCISKOzz6PffI
         jVAIuvWktLb1LM90UjUaOX1p7M6aOF0GUzWCRPL7zdfdtJqJTxhokMinqj+crSZqfBbe
         VVXQ==
X-Forwarded-Encrypted: i=1; AKwUvByoSunj1jYFpz0zR632tAV77BnPJ38BxRfbtkQA7WzAXseOsm0o3wLcYOuzJUjwl/dJUBfvuBRMG0M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqOCCWJFDSxuqIvJvErP9FmNTZE0vsE+S5yC2Mq78djLfZQPfQ
	sxwB/pMEAPnKwny/SnamGQxcoNKZufFuhkW740+78LgNNM8s9GNDJVtAZioIYw0O5hBd7Q5mI+j
	1KCfPUyk=
X-Gm-Gg: AYBFou0YGmEVHmOzHVz0nXz8OMolS6JLyh/jPvk1RCoXrkwGjYYWcz/djw8fS1N2eTp
	RPoy+Ejq7gPno7K/fNedBAOSjHWAwIJ692YEI0ohvjO6spWW8NB8LE4QSr8TLUy/sPD9OH1GM/d
	CaiOp6TXGVMI1EJsPXhcbUnyO54cKQqVSQebN+mghGAgyD7DKrF9R2kjgu4nrF+CW6zqGXQxvva
	buYKHdQEn5CDvkK+aivt1KacyBzbjttHQinCuk9zaJEvvcIHcoyJeGSMNZ6iAvkqgiVj7MwRdGt
	72mw3+nQtzCplj8JMtoDQlpKsngvpYl8SXk+pkMxXzFv9fceyQcYrycHCSGQkihPwkL90bShhwe
	JuQHyBfy5eyAZxKEqxTl4umxGEuTAyKmfzSde90RbJhXCyykpAiIWzMBJTieGE1kOvikCJrX4mj
	dJr1ptT7Kwj4VIBcWBk6nrZslLrYNJh50AXcyBpVFptYo3aBO9+j9HbAd8ChdTIvmgUrLBrZ0Sn
	tyTK3vwOVp9yzuKdg3wWcMcbCnCmPv1cc2B5fs6GbySDzoPyqs18sY=
X-Received: by 2002:ac8:5ad4:0:b0:534:b7b2:6353 with SMTP id d75a77b69052e-53629a699c9mr49329901cf.56.1792164514309;
        Fri, 16 Oct 2026 08:28:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa19fefsm25018821cf.23.2026.10.16.08.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:28:31 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:28:29 -0400
From: Gregory Price <gourry@gourry.net>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, John Groves <John@groves.net>, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 01/10] dax: add fsdev_dax_from_file()
Message-ID: <atJCherUxpYkRFa7@gourry-fedora-PF4VCD3F>
References: <20261016151638.2962413-1-mszeredi@redhat.com>
 <20261016151638.2962413-2-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016151638.2962413-2-mszeredi@redhat.com>

On Fri, Oct 16, 2026 at 05:16:28PM +0200, Miklos Szeredi wrote:
> From: John Groves <John@Groves.net>
> 
> If the file is a fsdev_dax open, take the dax_dev from the device inode's
> i_cdev.  Return with a reference grabbed on the private dax inode.
> 
> Make dax_dev_get() static again (internal to super.c for alloc_dax), export
> fsdev_dax_from_file() instead.
> 
> This fix is in response to a Sashiko review, and some subsequent analysis.
> 
> About the 'fixes' tag: this removes the export of dax_dev_get(), which was
> flawed, and replaces it with fsdev_dax_from_file(). It feels like the fixes
> tag makes sense for correcting an ABI error.
> 
> Fixes: 2ae624d5a555d ("dax: export dax_dev_get()")
> Originally-by: John Groves <john@groves.net>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

