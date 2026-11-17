Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878309;
	b=yyIQG1Wjb+v6LmKXf+VtlSUxzxj93RPW1Otk9oVghW5NrxnLOxj1p5OoT3tV/FKaieqs
	 jIjgd2XSQ6qq5oV5wYQeqYAy9BO+GlRS7GrB+kdRb1Z/CqTvp3Q+P40xUcQBuhs2+XVoX
	 dUpTx/DoFCRdnKqnM5ipwnTW1HWV6jWZXRk7tv5+yPYC+vYhozl+sYts6/l3FHJSm5aQ8
	 hBImS+CeEjL4RzwzmvrKiFFH5ErDZmrdE6iAwLKIe2YZitVCSMwCCyLA/K7w9ikAzQEJ4
	 VZDPCajNizH4lAg20aOG+BOlEF1zGuLpBqDRvNbau5Mi6VhpQXj9F32Am9MU9YbZ0eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878309;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zohyb9Hd2Fd5pNE+y9AkfvwAw05Ut0e2Tnrn7bJabG8=;
	b=tqMo4V39c5HAY8QzgSGj8SKXduSOWSx2/rQjLcVbZ5U2EShQBirvepAYgXr2LvhaR381
	 VWOb26jfsSI8uzAAofnXt/JAMZpkGfapkatY2bHpw1xUZCL5Fpvw7Mp0kuqguXVUsODWF
	 FmaEyfO/8eqtd0CwOjbXmAZPgKXINErav12U8Qpym4tnnyElEOZlFJNEYooXFQK8xaC/M
	 W4sAm3TuD6Kw81T1pg9EFtC6oNcif72tsUtGDRKCxak6gJAIS7IFfC2cqfswAleqEvdqb
	 PGcMl6+yR3deqW3WZ3VmsBGGsBM1/ymkgA12fm2Iarc9LTBbBS4xzEl6TsReaUcUYiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BzK80QvL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED000606A31C;
	Tue, 17 Nov 2026 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BzK80QvL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55C11F000C5;
	Tue, 17 Nov 2026 01:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794878308;
	bh=zohyb9Hd2Fd5pNE+y9AkfvwAw05Ut0e2Tnrn7bJabG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BzK80QvLY6SS9wzZFwvJYiFVdguBjSvb/qvIr/j5QKjMoHfW23D4O0kQonSdKRmTt
	 Y2XzDppfixuRhPz/DUUTlmsv93Gp7qJySuwhjOPU1v+62po/kzR46j+ydr2Q5MHEoA
	 dDlbVmYpU4r8mBGrIDi32sCm+uRi12xkUmSuMttb8y+/axfOLKVsLeE2EkZnHzffv+
	 qceyvK6h3REhBMQkZ5E7IDsTAqdyyG5KtGYSs2JtFstTQPErH37eGD5tu3VWILVMt3
	 xDVECVZGax0WelhVXS+sw7OFv44yE7re0FqQuSlmFjvf0Oj63OjIBCwKUx3DShUMaj
	 OR9wK2BuwOWWA==
Date: Tue, 17 Nov 2026 01:18:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, djbw@kernel.org, iweiny@kernel.org,
 icheng@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cxl/mbox: Use mapped errno to determine command
 status
Message-ID: <20261117011821.4cbf69e7@jic23-hlaptop>
In-Reply-To: <20261116070938.3675205-2-ming.li@zohomail.com>
References: <20261116070938.3675205-1-ming.li@zohomail.com>
	<20261116070938.3675205-2-ming.li@zohomail.com>
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

On Mon, 16 Nov 2026 15:09:38 +0800
Li Ming <ming.li@zohomail.com> wrote:

> cxl_mbox_cmd_rctable already maps all mailbox command return codes to
> errno values. Use the returned errno directly instead of checking
> mailbox return codes separately to determine whether a command succeeded
> or failed.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
