Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793387503;
	b=SIQcRaDN1Wp78AAxNT95S+7+yjweQRIvg6Hylf0N3DWb7UXY4O3xqhebG4LjrkiI3lJ9
	 FLZsGnM1EmHZHB8q4WLFSqJ6MxsXOee1dWZMTkyIXzpBRNUcU6vz31j1GcV7k/4PBnV0T
	 0etDPvLW6uDZBhZtA+vilitGo8wFvt/A3R6sudIVTsRAptacPkfMbrpILnc+kArrB899G
	 Oq8tfbRMnOaxqFrjaHfir7p7Q8USb7+KwkuZzmUMvErllv0dDSfzzYjOHLoo7Ho/5aRzU
	 3svbIKzCuQxUNH2ncPRIg+o3qBi+zX/EB/S3ttdhF77yldL+j4ihiN33BHLLOv34uLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793387503;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=MejGJQjR0eeHynwaf2K0BI7CBc1IkI/gaC528fBJyx8=;
	b=NVAeTExOC36UI30hepAMIBFeuBkRXUNpk8Ni7j5l0xZfC8pl9q4o9qc7UUrls0atYdF/
	 EjR+XkeYJsb53Tv+KHajzGUjXZjo8O5YQDvVa2bryMmc6zb2/ufX8QFm+BBvaTR4HymEs
	 mBYHbUwnhOqc07AfOD/z84jvzUcobuL4VQGSc7NgVqs4/zRVpcuN3V1AyzM4x62Jd8Tdd
	 fNrLHNiCsOavqqyCqmKrDQQ++aYYQPoKci5v/g2dfqHWSkH0svxYDRle79oFAmfbavadt
	 Kz4o353kUBWX8YQab8e6xL8QLQ+7HleP5Wmwt2JXppayUC79mFPNF/Qkd55n1JI4mTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=MQ0vftJd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FD606A333;
	Fri, 30 Oct 2026 19:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B87FD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=MQ0vftJd
ARC-Seal: i=1; a=rsa-sha256; t=1793387495; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lPA7JiA3ftSRb/DyFAKtNjTTR9xzcFXDj1vh7aE+vyyqqA2EcZa5mx1YFp4FbfICyeXcCRWUvHvv+NYCIjsMfYx17nubySCKVblB1tqad6Nbkj0nhHJAZZlA06ugkcGe7f6tv5GkzI1Fe1kugKTXM7lmMf3ORJZZY+p53cAvtCg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793387495; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MejGJQjR0eeHynwaf2K0BI7CBc1IkI/gaC528fBJyx8=; 
	b=friS97NirktPGkvosPIINx7wUJjrCWIO7/Ju8nT441Ib5a6EmI3R1Jbr0RSx6zqXUCs42ft9uiZZdEuG1y+SB9zqvyLcvlBJbTVMObKLVozIJGKcftTm1v4MVEOfVxgyOS4nKPL2dJ42Sp4BPtqUf/oHrwJNFEUEQ1P271IhUbI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=MQ0vftJdPBXCpIOVpitsd0MTLaBOHWXeQL/fj9NkPZqr7Drve/073oOEfSN7DCFyLzDSahRpz/kQ3V50/pOQFPTCQZ6CbAt9/VVagYUdcm0BrktBMeHvT710PzT0oxmeMQkkhnpTkL7m7BaZEMVAfuFr1J9wk4H27ym/LzE6a/k=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=MejGJQjR0eeHynwaf2K0BI7CBc1IkI/gaC528fBJyx8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793387493279176.3797193726208;
	Fri, 30 Oct 2026 12:11:33 -0700 (PDT)
Message-ID: <e362b604-58da-43c8-bc3c-904becf92035@zohomail.com>
Date: Sat, 31 Oct 2026 03:11:29 +0800
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/port: Unmask AER internal errors for VH endpoints
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, kaihengf@nvidia.com, kobak@nvidia.com,
 newtonl@nvidia.com, kristinc@nvidia.com
References: <20261030095951.46080-1-icheng@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261030095951.46080-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227d4cd3fe03e4dfbad211110320000564959910c5844141bd21f41fccaea78dcb22fb0611ecd4654:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 10/30/2026 5:59 PM, Richard Cheng wrote:
> CXL protocol errors are reported through PCIe AER internal errors.
> Unmasking the endpoint's CXL RAS register alone leaves the AER internal
> errors masked, thus the notification can't reach the Root Port.
>
> Unmask AER internal errors during native endpoint RAS setup for VH
> devices. Allow cxl_port to use pci_aer_unmask_internal_errors() through
> its module-restricted export.
>
> Verified with QEMU mem-data-ecc injection: the Root Port AER interrupt
> fires, the CXL correctable-error trace is emitted, and the endpoint's
> CorrIntErr counter increments.

I found the similiar implementation[1] in CXL RAS support for VH patchset[2], seems like it is under review.


[1]: https://lore.kernel.org/linux-cxl/20260902133933.2992457-9-terry.bowman@amd.com/

[2]: https://lore.kernel.org/linux-cxl/20260902133933.2992457-1-terry.bowman@amd.com/


Ming

>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/port.c     | 7 +++++++
>  drivers/pci/pcie/aer.c | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index c48216e5078f..c94a310061b0 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -121,6 +121,13 @@ static int cxl_ras_unmask(struct cxl_port *port)
>  			orig_val, val);
>  	}
>  
> +	/*
> +	 * RCH errors are reported by the RCEC. VH endpoints report CXL
> +	 * protocol errors as PCIe AER internal errors.
> +	 */
> +	if (!is_cxl_restricted(pdev))
> +		pci_aer_unmask_internal_errors(pdev);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index db4f607f889c..94eca22422b7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1287,7 +1287,8 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   * Internal errors are too device-specific to enable generally, however for CXL
>   * their behavior is standardized for conveying CXL protocol errors.
>   */
> -EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
> +EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors,
> +			  "cxl_core,cxl_port");
>  
>  #ifdef CONFIG_CXL_RAS
>  bool is_aer_internal_error(struct aer_err_info *info)
>
> base-commit: f0c48323b0402349530abc60ea908b5f5f40c395


