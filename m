Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E239CCF1;
	Thu, 23 Jul 2026 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791804; cv=none; b=QWZPQRO+m+xgn3nowU1rxWakPWZrBLkS2iuaXwt6pEJsFRxLOJB3KlDAOGFnauVGwq6wN/nakdw4UepmdODbG+Jl14eATniAJXtjvpjW3r8y+SXUhIALHUfX8KjBLYGNWNxn5oofMoj1V2//BBkiUx2zBMcICLHZtldqMc42uyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791804; c=relaxed/simple;
	bh=EDa+Vhrio5pXDEsP6AOPKv9DQ4J23qqrInsNZEKJedA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vy7UUuB8DjLBzIgNu5/dHfoJH3f+Mb/q8F+OFb4OrSLd1lEdz1m4cwgacTQcAkagoc4yVRvhsuTnBQvn2dxWpsv25mbrE1Ye9/56hNtfOTk/+UwIhIvlX1tl11iiMe3NDunBUSrVA0XJ07NzTDsOh64Vt2x74Uvj6CllmX8HswY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA021F000E9;
	Thu, 23 Jul 2026 07:29:55 +0000 (UTC)
Date: Thu, 23 Jul 2026 09:29:53 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Lukas Straub <lukasstraub2@web.de>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Zhao Liu
 <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>, Markus
 Armbruster <armbru@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Alex
 Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>, Hanna
 Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, Stefan
 Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Igor
 Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, linux-edac@vger.kernel.org, =?UTF-8?B?TWFy?=
 =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, qemu-trivial@nongnu.org, Jonathan Cameron
 <jic23@kernel.org>
Subject: Re: [PATCH v2 02/44] qapi: convert intro sections for
 acpi-hest.json
Message-ID: <20260723092953.1affa5dd@foz.lan>
In-Reply-To: <20260723044805.527643-3-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
	<20260723044805.527643-3-jsnow@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 00:47:23 -0400
John Snow <jsnow@redhat.com> wrote:

> (Trivial)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/acpi-hest.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
> index a01f1dee095..8db804df197 100644
> --- a/qapi/acpi-hest.json
> +++ b/qapi/acpi-hest.json
> @@ -13,8 +13,8 @@
>  
>  ##
>  # @inject-ghes-v2-error:
> -#
> -# Inject an error with additional ACPI 6.1 GHESv2 error information
> +#     Inject an error with additional ACPI 6.1 GHESv2 error
> +#     information
>  #
>  # @cper: contains a base64 encoded string with raw data for a single
>  #     CPER record with Generic Error Status Block, Generic Error Data
LGTM.

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


Thanks,
Mauro
