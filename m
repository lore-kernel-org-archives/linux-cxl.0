Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451416;
	b=f3InicWysGHzMKHPDJxAk/0mUbJGjDNGxx9j8UOUOBGWu7N6rxYCBr6YdNIdd0vvQLPG
	 4ypuBvxQLUEGeJm7jByyLFWLInA3+Z4SxQ5Owhk/78wUsUisZ9aGz1hG5TlzDfUeIlRfe
	 qiEWt3zCnyfMnJ3cy7Q2urq8iRRreMfjKL5qBgKvPKhYUzthGA11EK/5i+8XwBsJ9sbLA
	 m2Ht8s4U7T4YzMvd9DelwNSpbCVlq+Ojor4LxQZveWvPLWS6fn8dPbYWTKRSIuvsLvr8M
	 aAxmy04j/Vvf0c3TeGRdxOZOmpeFFfuWL/lLlHd0O+zxqd61Td2M7hf/Ro6kBTANrBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451416;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Jhj7Cft29b7Sj1usDrXdmiSrzlSlVGS0qEI5IQb2t8U=;
	b=1Co26LpKdHNiQhZydK6nZKhVUKqW3qxBlViZtH9EmmUUTEpNFVf7UGrjosehPt2FJwa7
	 LoyMU2VapSsbniAdW5LhHhrMd0Y1eS3ZUResAovLraxraIJzYKc2sV5yNo1UhGGZHz7ck
	 ZsthqWo2UPtaYkhgj7lZ4VYKFpjYKPvjBF5ojL+e678t7jv03hjGRTa9kAzZ5aU5hw8oW
	 //sDdD1Vu6TYDDQLBTiNRMT7NYMtYC4MRuo4eLgswjBgFwZ4ONexIwsXwhSaYY8JTvUGa
	 4XfeDLGmiytaMHvymMk4lVjeSg1jOzaH46nCcv4tmTc1J41ZZVQ6cKQkfv4XkJbtSYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPnkMlZh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44B606A323
	for <linux-cxl@vger.kernel.org>; Thu, 12 Nov 2026 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPnkMlZh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEA61F00A0A;
	Thu, 12 Nov 2026 02:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451416;
	bh=Jhj7Cft29b7Sj1usDrXdmiSrzlSlVGS0qEI5IQb2t8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mPnkMlZh1F5lT5yleliLxLUCbpZxeldweMav4PAVncGQ+JgilnCpvYWfUh1LH0KOn
	 hc05Qb++Sl/FmPkLx4PodI+93VQ2/tbw2ZRf9U4Yz1DXb3hqmYORXImpFlLmVEQSEe
	 9n3dX8DjUbXgpLVgV3WrkfZj2CbgTJ6up0GXgYiDlefVql2Qlb1aB/2fSKR7tHLwpK
	 n/xZ1FKq7Tupq8uoiVHxT03wC1LWakkQ/BxIgBahGSgzyNMN9FDo8ATi27U1pEZLHj
	 wvjdkZjReOeYmfeZN6GYuJKWj+Wwx7p0otDnY2v314VlubPfuuG8x3Kr0sQYFokNOM
	 bSaaRVaCLsWWA==
Date: Thu, 12 Nov 2026 02:43:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, Ben
 Cheatham <benjamin.cheatham@amd.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/test: Free the decoder registry when
 cxl_test_init() fails
Message-ID: <20261112024327.6df82a6b@jic23-hlaptop>
In-Reply-To: <20261106222240.958402-1-alison.schofield@intel.com>
References: <20261106222240.958402-1-alison.schofield@intel.com>
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

On Fri,  6 Nov 2026 14:22:37 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> Decoder registry entries persist across mock device removal to support
> topology replay. Sashiko review found that if cxl_test_init() fails after
> decoders are enumerated, the entries leak because cxl_test_exit() is never
> called.
> 
> Free the registry entries and destroy the xarray during error unwind.
> 
> Fixes: f3b1d2260703 ("tools/testing/cxl: Enable replay of user regions as auto regions")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
