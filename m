Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878225;
	b=aTNNU+k1bszmfdiIujXLsQsIa43Oj4wIFvQEU0hhorlluzDVjTOjDQFuWtNhUT9LLbmR
	 v9S1ufJJSoUjvu6pQKFnkfOwc0/SroxrYh9GD8mkYNK/4eRu8T7hOktwb4hvH5l24RHlM
	 XDzopF6vXN2mvvJh90yE5zfJ48kLCjAlR9X1EmHCNDn27sin+BSJMRfAgXa9MRbM7gBOV
	 kB+F6d6EwOOTkqFF8Xv7Q+CY1LwVr1KteZGo2ETFZS2S8jrEF/ZsorojIUfQcGwNrabV+
	 BsgIgz0rNzHRh5eRyD7ITRr0+Ep6ulRSODLqAsiYkdGuLJ2t5lqRym8cHQtk5neXVqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878225;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=15GlR8BnfLmyFEAu3RtAsoYHk3PL9IGaBtlbULBhJMA=;
	b=1mWOVGLc1obI9moEdnRphPLtVz2jSTIW+irtsPIr67oiRM7s8aU2RvJ66238A1NGix32
	 HWdw1PUbv4DAOy8pmmMc6DhMElUIXQHC5nI2aQOMul0dooZakH+EhRJfgEokBVZRkvKW4
	 uMQYrUpVsiguuZ1ofzw63tXeZcFYDc1kbCf37qtkEgt+++RBUcp7mlQqXFEnxwRonKhTO
	 PfB2asX5R9T+xkYJWX4edbSz9uDCPo62ORCXjRIutA2q3Vo+8Mai2V99gKY9UFrQq7FHJ
	 AL4ho+Nf8nna2OOx786lD7R24lX9gA0zLH9bBPvCg2l0zcRe2pHe8bc6mZN4RTLxZZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvFEOsae;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69634606A323;
	Tue, 17 Nov 2026 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvFEOsae
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BCC1F000C4;
	Tue, 17 Nov 2026 01:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794878224;
	bh=15GlR8BnfLmyFEAu3RtAsoYHk3PL9IGaBtlbULBhJMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gvFEOsaerobXfon7iItCtvxZUf2aVuy+89ZXEe84I54SP9rH6n7hLqKujXgEy0R+W
	 pLusszmaz06IUQQl0zlR8ODOdhiuljCm+Z65+8Buxpj6Dg/27fsQSwL8TDxfUlqwfS
	 p1JFrPIhroAMr9CVSYD1bFCbVN9NnzIzb+7buJBbt9InGYc8MgcXmcU3sVyDI/dTd9
	 a7gPcevhqA+bXwro02t31u8u+cPXtkl2Z+tI319ClrBT2yPRxQDpXesP4w4quXidDc
	 Ycu64SFGMRfE3QvoLl50rFcbspNDcSGsmH0oT7ELW5WXmv2jDZx+5VL8ZBINop6hG/
	 +AVkrCoGpP9tw==
Date: Tue, 17 Nov 2026 01:16:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, djbw@kernel.org, iweiny@kernel.org,
 icheng@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cxl/mbox: Return success for
 CXL_MBOX_CMD_RC_BACKGROUND
Message-ID: <20261117011658.2b1d3cc8@jic23-hlaptop>
In-Reply-To: <20261116070938.3675205-1-ming.li@zohomail.com>
References: <20261116070938.3675205-1-ming.li@zohomail.com>
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

On Mon, 16 Nov 2026 15:09:37 +0800
Li Ming <ming.li@zohomail.com> wrote:

> In CXL subsystem, each mbox command hw return code is mapped to a
> corresponding errno value. Currently, CXL_MBOX_CMD_RC_BACKGROUND is
> mapped to -ENXIO.
> 
> However, per Table-8-208 in CXL r4.0 section 8.2.9.4.5.1, a BACKGROUND
> HW return code indicates that the command has been accepted by the
> device and continues execution asynchronously. It does not indicate a
> command failure.
> 
> Return 0 instead of -ENXIO for CXL_MBOX_CMD_RC_BACKGROUND so that
> callers do not treat a successfully started background operation as an
> error.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
