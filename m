Received: from isrv.corpit.ru (isrv.corpit.ru [212.248.84.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470833FBEAB
	for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.248.84.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359099; cv=none; b=aB4hHXUomGDAOzUKM9MvqdE0wr8hyKjGTsMvmqARcx61b8USaw5wX0Q/oC9OsK11dQU31CwaHFRojUiC2fWFz+vfAjZAOMo/sbtsSCD5YAtZLh9QSVLDMwiXaJIubfEFK++kANDKRbf8nffhwhJdVZe1ZIHpV9kokqnClLOuEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359099; c=relaxed/simple;
	bh=dg3b3VKHVS4l5SThiNBetk6wArEkL0YdDlS1rvaJf60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+5clBCVGTK6YF73hmTLaplaoDdAIbOp0YcXqX+lIoSSmvyfyHNBtHeW5P3ydYMERTpTo6xHSmneq2GkRucJLonfO+z1XnR/FofyXsj6rkbTRSjujGNAD+3rh74UkLaRm4FQ1urh774IP46PTCfJvnlwOFi0CfE/UXx/kfTezAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru; spf=pass smtp.mailfrom=tls.msk.ru; dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b=Y0YMm0x9; arc=none smtp.client-ip=212.248.84.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b="Y0YMm0x9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
	t=1774358733; bh=dg3b3VKHVS4l5SThiNBetk6wArEkL0YdDlS1rvaJf60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y0YMm0x9t/wvVC4hx7/juaUbvgIUgGOs60Mvk/eEP1YSESs1/SovLe4lw+iKJPrUL
	 eRfc4SZorDt0pHFf9HIrAc8cb9Ukjl5qX3iQ9Zsk/Z7IGRRuuA2U/CdhPkOAx6QbyX
	 s90utk436Xa48H+02ZxYuu9gQ5hfTn+TC/A+m6kUA7cxj7gBQFwkrWwCBDujwZNHFE
	 YC0AcmpVVsAW2FoAL9oxF8h/8Ec40GdJmKhQ6wyrUI8cUDNeGv9G3jzQBn6ITJUqvM
	 WQfSe9F//J6NsYGdWOjwMvox9WiOFrem70oNOW7LhDYPN4H2W1vEWUn4w1zgahbBnG
	 ijZRHQldbnHqQ==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
	by isrv.corpit.ru (Postfix) with ESMTP id 6F81A196FC1;
	Tue, 24 Mar 2026 16:25:33 +0300 (MSK)
Message-ID: <96061f5f-cdda-4bf1-9ab4-97400fcc9344@tls.msk.ru>
Date: Tue, 24 Mar 2026 16:25:51 +0300
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 -qemu 0/2] hw/cxl: Media Operation Discovery fixlets
To: Davidlohr Bueso <dave@stgolabs.net>, mst@redhat.com,
 jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260319184256.3762391-1-dave@stgolabs.net>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260319184256.3762391-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.03.2026 21:42, Davidlohr Bueso wrote:
> Hello,
> 
> Changes from v2: indent fix in patch 1. Added reviewed+fixes tags.
> Changes from v1: cleaned up comments in patch 2.
> 
> While working on the driver side of this, I tripped on two qemu issues
> around discovery semantics. I think this is the first time these code
> paths are exercised.
> 
> Davidlohr Bueso (2):
>    hw/cxl: Respect Media Operation max ops discovery semantics
>    hw/cxl: Exclude Discovery from Media Operation Discovery output

Hi!

I'm picking this series up for qemu-stable (10.2.x).

Please let me know if I shouldn't.

Thanks,

/mjt

>   hw/cxl/cxl-mailbox-utils.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 

