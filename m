Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722040B0E1
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784797915; cv=none; b=kxznFvtIWzbooD0uOnyjra0bB3wYlOkNkGuGN/J+LmgnGRja2v1mevyNJeSaTVB5T9aPV+eLehCYbqTxd6bzicZiZVkq/Evkow8oCiMMYfW0A2a31WA+/AkL5SzslYHmSZghSkmLxZc8BLcYNIjJEP+g3vkG9KzF/QWlBzNdEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784797915; c=relaxed/simple;
	bh=YVkjv9FjYBKj6eSmPJYTcLtHtlqO+AlK7IHagS7bYkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHkecgBKxt4+LWfxNlwV9djCcaAap5DS2O7NKRfW94rv5cq/sDX8JT8he+6CCplh7YaXHehTe+w/6MT0eGp2GvUZqKC+EiprvWbpBeMss+IkrXpxfBVX7OTmxtbV6nwa43Gsvd2KTx8KQ+Bj9tXsIuGYN6rBp/ret3ECB7z7WH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jQIhRa7d; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jQIhRa7d"
Message-ID: <344dd201-27c5-41f5-acb1-a6bb4c7192f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784797910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ph7nu7v5ynKoGLeN6brlvQB+6K4JFjnx8hTC6Ek69CM=;
	b=jQIhRa7d7a71Qb5eYzYKY5rr8fCi3w8825EkGf8oS7fErG4JRkxRoLoMz3cV8Tx2V2vFx6
	gBSC4JAhHh5Ul0wYdarkwPv7+4HYuu3ucVb9gEALTeFzzLIkTiKn7yTROGN2y1yImohY7U
	XhqWorSuB8BzCAhpwYZPUbyhyWiYBNo=
Date: Thu, 23 Jul 2026 17:11:25 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 09/44] qapi: convert intro sections for cryptodev.json
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alex Williamson <alex@shazbot.org>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, linux-cxl@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-trivial@nongnu.org, Jonathan Cameron <jic23@kernel.org>
References: <20260723044805.527643-1-jsnow@redhat.com>
 <20260723044805.527643-10-jsnow@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: zhenwei pi <zhenwei.pi@linux.dev>
In-Reply-To: <20260723044805.527643-10-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

LGTM.
Acked-by: zhenwei pi <zhenwei.pi@linux.dev>

On 7/23/26 12:47, John Snow wrote:
> (Trivial)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/cryptodev.json | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
> index eb309c22f86..d0c1e6c8944 100644
> --- a/qapi/cryptodev.json
> +++ b/qapi/cryptodev.json
> @@ -12,8 +12,7 @@
>   
>   ##
>   # @QCryptodevBackendAlgoType:
> -#
> -# The supported algorithm types of a crypto device.
> +#     The supported algorithm types of a crypto device.
>   #
>   # @sym: symmetric encryption
>   #
> @@ -26,8 +25,7 @@
>   
>   ##
>   # @QCryptodevBackendServiceType:
> -#
> -# The supported service types of a crypto device.
> +#     The supported service types of a crypto device.
>   #
>   # @cipher: Symmetric Key Cipher service
>   #
> @@ -46,8 +44,7 @@
>   
>   ##
>   # @QCryptodevBackendType:
> -#
> -# The crypto device backend type
> +#     The crypto device backend type
>   #
>   # @builtin: the QEMU builtin support
>   #
> @@ -62,8 +59,7 @@
>   
>   ##
>   # @QCryptodevBackendClient:
> -#
> -# Information about a queue of crypto device.
> +#     Information about a queue of crypto device.
>   #
>   # @queue: the queue index of the crypto device
>   #
> @@ -77,8 +73,7 @@
>   
>   ##
>   # @QCryptodevInfo:
> -#
> -# Information about a crypto device.
> +#     Information about a crypto device.
>   #
>   # @id: the id of the crypto device
>   #
> @@ -95,8 +90,7 @@
>   
>   ##
>   # @query-cryptodev:
> -#
> -# Return information about current crypto devices.
> +#     Return information about current crypto devices.
>   #
>   # Since: 8.0
>   ##

