Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943464;
	b=WNWSjg3yFFzyYLvUOuNNyA9iRg6qF1Uvm6c8PSyr50PXjmJzgSd7f+TAcKxCp/fNYjDz
	 riOsd3JBdvgKFvTiaip+prBikct8/VyeKtubvd24VJwTUeOWpwD0MASBL3hwbjIcIuN4Q
	 Zwb5BDc146u6g9SxUAdwXdEW6UilrWGjOecTIKhDlwfgbG4RT03bcKlP86ezybVRsBE9s
	 ZLP/IgDvPcOxh32Rgb2Q9ve9HhZfdBbHn93H7XWnMvlpKJHkaKqASq5opJeLYJ+bIW1rz
	 k4OMv0/q9s4TMPl+noiL70usW6cDkdoKO45SLPcwh41t2KoCMjduIQBM6hUHp5O/yJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943464;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=OHoYg2E45BTgUddWtg/8lSCBTiZ+0wRR3Gkvs0TrpmU=;
	b=yZc1HT9i5x4KoUON0YgcGc4vJJVbdEgCGMoLTNCOa7ARA+oTKfircsmY09hlW3MW6lAa
	 RjfHjqISIDUVpTPhU8DO9JIqK7CO3OtrTdI2rzG1fiOhYhXyqgGcL8WZ4j9BAoZXynGRv
	 +cXgxnUwjJ+xSFSBoMJsqYJnkXb5EnQxgq9oA8AF7AABDhgPKOpAoEX6+AtHWGni9Vjqp
	 cIBVV8QlmUbjFLrWoYgSy83E+o4sP3KGkWMzSlumw9h+464SarV0VY9uWabklNWvYSmsq
	 Uu5sst7YGHm+NxuUw/gB4vqkmeOcO45w/LXxzXWNeMFDlH6a5QvHcirZHxR54zWvw1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Yr8L0raP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.92
Received: from sender6-pp-o92.zoho.com (sender6-pp-o92.zoho.com [165.173.180.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729A606A326
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 05:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9729A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Yr8L0raP
ARC-Seal: i=1; a=rsa-sha256; t=1793943458; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mUeTqa3lClXS/MSkQobS6Var6GYr4ah+PpnsjASdhLymALR93ENHRohNFjEH/rg/nUPb0q1qOZI6KiIUdBVoCj3UmF6gup7xJSWIvBge/KFZRN3C00Q7At7R6c/3jwHoLPYQrRXffLhrvB8GOTsIjLNM5MmaJA+FxeI7oudSrjo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793943458; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=OHoYg2E45BTgUddWtg/8lSCBTiZ+0wRR3Gkvs0TrpmU=; 
	b=Iixm7GC9IPUhjsUFIcIr5pUq2GEUOZ+ArMEHGddtgpA8d2ifyLg11vhU3UJ/rruydIQfisouSDc70OxsIe+jDaX1vX7d3ZJO6AdqpFL2ywT2b09DhGbJii5d7OqtJc8ZdVRAegi9E6OHn5Qk0n2ADvcndDcWESAqJNCVhMgyGEA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=Yr8L0raPcoQmFeI4NBEdmM8W+VsoBprR5V4kptSvcjuAumUcbvvttdIBeUQWozpKHBe7V5tYVhHJ/UPVgNoh0vLIN9JJU4ZaF0i0dwCr0ah4PxI9xaKuZ5ptwCS4N5WSuSXfopCxP572bZvVQfCWiZbYr0iDQ8pAS6r+40zK9LY=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=OHoYg2E45BTgUddWtg/8lSCBTiZ+0wRR3Gkvs0TrpmU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793943456873645.9635994778267;
	Thu, 5 Nov 2026 21:37:36 -0800 (PST)
Message-ID: <b049abad-dd7c-4169-9bc5-3158b8e939de@zohomail.com>
Date: Fri, 6 Nov 2026 13:37:33 +0800
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
Subject: Re: [ndctl PATCH] test/cxl-destroy-region.sh: create RAM regions
 explicitly
To: linux-cxl@vger.kernel.org
References: <20261106014848.938714-1-alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261106014848.938714-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu0801122795b4757f0fe001e2f806ca6500004ec310427b4025bbe2795daf1bb4ca29203636b59f442c9238:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/6 09:48, Alison Schofield 写道:
> The test creates regions it expects to be RAM without passing a type.
> create-region defaults to pmem when the root decoder supports both RAM
> and PMEM, so the test fails when it picks such a decoder.
>
> cxl_test has one such decoder. Whether the test picks it depends on the
> memdev order, which changes when other CXL devices, such as QEMU-emulated
> ones, are present.
>
> Use the '-t ram' option so both checks create RAM regions regardless of
> which decoder is selected.
>
> This issue appeared while the CXL kernel patch[1] was being tested. It
> changes the cxl_test created x1 volatile window to one that support both
> RAM and PMEM.
>
> [1] https://lore.kernel.org/linux-cxl/89e8d2cfde4f1054f37a4f48f2b206a7f05108f7.1793850480.git.alison.schofield@intel.com/
>
>
> Reported-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   test/cxl-destroy-region.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/test/cxl-destroy-region.sh b/test/cxl-destroy-region.sh
> index 5c3395e530b0..b07589fbbe39 100644
> --- a/test/cxl-destroy-region.sh
> +++ b/test/cxl-destroy-region.sh
> @@ -60,7 +60,7 @@ check_destroy_ram()
>   	mem=$1
>   	decoder=$2
>   
> -	region="$("$CXL" create-region -d "$decoder" -m "$mem" | jq -r ".region")"
> +	region="$("$CXL" create-region -t ram -d "$decoder" -m "$mem" | jq -r ".region")"
>   	if [[ ! $region ]]; then
>   		err "$LINENO"
>   	fi
> @@ -76,7 +76,7 @@ check_destroy_devdax()
>   	mem=$1
>   	decoder=$2
>   
> -	region="$("$CXL" create-region -d "$decoder" -m "$mem" | jq -r ".region")"
> +	region="$("$CXL" create-region -t ram -d "$decoder" -m "$mem" | jq -r ".region")"
>   	if [[ ! $region ]]; then
>   		err "$LINENO"
>   	fi
