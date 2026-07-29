Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAFB468C05;
	Wed, 29 Jul 2026 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352283; cv=none; b=ZeCZZ88+9BfomzKAugWhPu51CykRbWNe1ZpRHH8ubUVVOJltmD1L/Cz2GYXkew39nh0J8tpfNO1ygKr+fIluTxjITMA4oz7UYOG6a+nNrvq0Cr1mqCujjqeENTsAC+m3UgeM96y3PsfPqR7fOuwxZk9dKNzbOPap9f0zOq+CodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352283; c=relaxed/simple;
	bh=XShsP8cL+4M0WaaElgWelTNGmpfDkNR5V7HlMuScjts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDpwKRStAsY84hJEI6oCFmznjs8AU87DFGQYK4uwEUozz05LPlmhFloNz0qT1wxz4UnfXTah54svWs9HEu9fEbRO2ZHsvdFvI8NEW0aH0Sg4rKQlpxLeO/teqfodCNTsJE7DYMipIa05EhDH2e63CyUuyDgQG8BYtAjizySL1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=t9gfp2sa; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="t9gfp2sa"
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
	by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 15DC3C0235;
	Wed, 29 Jul 2026 22:11:14 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:484::1:24] (unknown [2a02:6bf:8080:484::1:24])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA id ABkPESLWT0U0-10TKtRX1;
	Wed, 29 Jul 2026 22:11:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1785352273;
	bh=BBayXCrmEuxM62n4vJsiyicvfg6LL27hCE0P5dz9xHM=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=t9gfp2saepz3+mG7OVVn6wdNYAhO53wxY+71ngl7i+M3Cd1MqjjkKighPODOk38cS
	 HLek12z98QXr5TgH6x/lf8kRnx/ql3ElrZF8jXzLq5Um3tQ0Bp+WmbbhzRcaCdmffx
	 KZy9Pqaf61sKkmJoNRnB/IotqShcL3o8CAv5pL1E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <6c1394b3-279c-44ca-b20b-7d3b3abf3f42@yandex-team.ru>
Date: Wed, 29 Jul 2026 22:11:10 +0300
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/44] qapi: convert trivial intro sections for
 job.json
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Zhao Liu <zhao1.liu@intel.com>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alex Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-trivial@nongnu.org, Jonathan Cameron <jic23@kernel.org>
References: <20260723044805.527643-1-jsnow@redhat.com>
 <20260723044805.527643-26-jsnow@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260723044805.527643-26-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.26 07:47, John Snow wrote:
> (Trivial)
> 
> Signed-off-by: John Snow<jsnow@redhat.com>
> ---
>   qapi/job.json | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/qapi/job.json b/qapi/job.json
> index 31618e6ebcc..b68d7292423 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json

Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir
