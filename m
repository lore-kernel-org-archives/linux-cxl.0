Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569E373C17;
	Thu, 23 Jul 2026 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802035; cv=none; b=YuyGfFuL7NgfPti5miBtVlP4cShKYnGc1auh0A0t27MdHo+8a4sQ8cCWCEeinUvo5dfjfxUaufMgKQ2ehx+fGX+y9zTWCdT9taaxFdFHj8RzKuUkCkyzpgIiULITBcR9KOuP+F9an9wr7WYuSW52mT9jRh5H6NqDCU+JITv4DsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802035; c=relaxed/simple;
	bh=ETt/Hl7oW6PK5eDTM1zA+ZQpgeuScjS/ZyLFzI2aiP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEsNP3C/nM80xlgBYepc+3WSiXvKQYDnOcQt7vGezy2Qp7n+JJabfqzi3iz5IJn7fesCsEhFbVBNUIeIDgperogbG25FvHgxqtY00O/IRpb6gadO0IN5mYbJmgz1y6QsCcQMOnmyNXImK9t6HrZ8EwoLUWTqQkvNc4RmO1s4TJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=lukasstraub2@web.de header.b=fKleNQfK; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=lukasstraub2@web.de header.b="fKleNQfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784801984; x=1785406784; i=lukasstraub2@web.de;
	bh=pxVPAP9cay1OArTUUmyp+qn1tN6AsYyOvutDZUfkKSQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fKleNQfKw534xOlqKMkXg8jPaaNzFxcAw2Ln5tgDRIR8Ki3VuiN+zqe+B7ku13SQ
	 qBwcRPHlVOoiWwpPabAzXW/OLPZ410GuwQWOUlb4q7XEE2CxHXIdTbG5pIljov3iA
	 Rd61zWXZ1w8WuasMfW8YWv4Xt+TGRkIYt6LZrNmz2QPUUhtVYM49/NZh/QQF5YWpv
	 eg7WsZ78Nxi5vWH4zFy+APR524NiaKdbJBEP+tAXZL3AEQIFxsDAUdAJOUgYG7B2D
	 C0+KytFk8CnNl63bbop42pEiJdtHT//2J0wKPSnbdlVspaJo3I5M3RtC7JDvMWzp+
	 Js9pSfL0uZNUJQzEEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MC0LH-1wh2BJ0uDd-002Br1; Thu, 23
 Jul 2026 12:19:44 +0200
Date: Thu, 23 Jul 2026 12:19:31 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier
 <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>, "Gonglei
 (Arei)" <arei.gonglei@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@mailo.com>, Alex Williamson <alex@shazbot.org>,
 zhenwei pi <zhenwei.pi@linux.dev>, Hanna Reitz <hreitz@redhat.com>, Ani
 Sinha <anisinha@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, linux-cxl@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano
 Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>, Michael
 Tokarev <mjt@tls.msk.ru>, Igor Mammedov <imammedo@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, linux-edac@vger.kernel.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, qemu-trivial@nongnu.org, Jonathan Cameron
 <jic23@kernel.org>
Subject: Re: [PATCH v2 13/44] qapi: convert trivial intro sections for
 yank.json
Message-ID: <20260723121931.2427a8e6@penguin>
In-Reply-To: <20260723044805.527643-14-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
	<20260723044805.527643-14-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z9nrlx=IYKvMt1IYn2OQ9CU";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:lEmLyhMZjBXSJY3xATiY7vyCUJMHaXgbtblfHQhoJ5tHNg5O8vq
 AD3O9eephN3GLIReoW0BLQRdmIMs1WPfaO2+LDIxK7+BEn5ykYo1uDsk6iobW/k4LkABiaE
 CVfbhbnketMaI9EwIuWOgoinq5srvOu91+VQljT8dFx00ifEVwixwu0lBlDzIBTGYWpxSIq
 2tsvHz1qw3n5pu3I9eE2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0MalQRthREE=;gEIguQW4HHuz8e9/Q3jvI+rEuud
 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
 J9nafWEBldY+OsX8HKNEC/izg==

--Sig_/Z9nrlx=IYKvMt1IYn2OQ9CU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Acked-by: Lukas Straub <lukasstraub2@web.de>


On Thu, 23 Jul 2026 00:47:34 -0400
John Snow <jsnow@redhat.com> wrote:

> (Trivial)
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/yank.json | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>=20
> diff --git a/qapi/yank.json b/qapi/yank.json
> index f3cd5c15d60..8ac4b773653 100644
> --- a/qapi/yank.json
> +++ b/qapi/yank.json
> @@ -10,9 +10,8 @@
> =20
>  ##
>  # @YankInstanceType:
> -#
> -# An enumeration of yank instance types.  See `YankInstance` for more
> -# information.
> +#     An enumeration of yank instance types.  See `YankInstance` for
> +#     more information.
>  #
>  # Since: 6.0
>  ##
> @@ -21,9 +20,8 @@
> =20
>  ##
>  # @YankInstanceBlockNode:
> -#
> -# Specifies which block graph node to yank.  See `YankInstance` for
> -# more information.
> +#     Specifies which block graph node to yank.  See `YankInstance`
> +#     for more information.
>  #
>  # @node-name: the name of the block graph node
>  #
> @@ -34,9 +32,8 @@
> =20
>  ##
>  # @YankInstanceChardev:
> -#
> -# Specifies which character device to yank.  See `YankInstance` for
> -# more information.
> +#     Specifies which character device to yank.  See `YankInstance`
> +#     for more information.
>  #
>  # @id: the chardev's ID
>  #
> @@ -47,9 +44,8 @@
> =20
>  ##
>  # @YankInstance:
> -#
> -# A yank instance can be yanked with the `yank` qmp command to recover
> -# from a hanging QEMU.
> +#     A yank instance can be yanked with the `yank` qmp command to
> +#     recover from a hanging QEMU.
>  #
>  # @type: yank instance type
>  #
> @@ -74,9 +70,8 @@
> =20
>  ##
>  # @yank:
> -#
> -# Try to recover from hanging QEMU by yanking the specified instances.
> -# See `YankInstance` for more information.
> +#     Try to recover from hanging QEMU by yanking the specified
> +#     instances.  See `YankInstance` for more information.
>  #
>  # @instances: the instances to be yanked
>  #


--Sig_/Z9nrlx=IYKvMt1IYn2OQ9CU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmph6rMACgkQNasLKJxd
sljK4w/+Id0AP8insCHJ3FO+GTq0v1mieyttkyhskrVsVjUW9Yk0uAMs3I+BfdWq
7ywVjXVLloG7W9g+UL+f0YLQ8/UQjQnOSn/J7AVjVF3mwVs+5Ci4MY3YwT2KAhng
mLBPXu8edzLCkQKdjEI2VEtK8ojy4MybdJ0f0D06OlbVXYQEId9QC06gX0+tVKDw
MmMCkPRdGA+OT914OQQqSW8roADJ1eGAGg46yXnvb67PmLkSekRsbfSeayTMjbYd
8LZ6T0JfwC9TvymNNVfSpzpXGexoastZ4F0XS+sAQeo7drpUUIPlYCSaJEkQ8qr5
ADUOSt0ll8+lU9xaJDsqr4/ZmXxihFJIZQQ9xkTt50HbYBajYofhCmZaYqoMg0PE
KYwFKYRs43LaeC88yHpuWH4XkbjjRXAZZ74Po4APsBipwXTUsvBlfihm3b0zZHFc
rG3w/AZxeqXPTrAVFu7cfHTwHwhvhgDtWgGyIe7Jy/CXVbLKeYmAqBepNDpyTsY9
/5HiKJYK9IaV78VkYmDpjqL2urkAnysZEBNAof/oJhjiy56ZUW6aDjkevN30oFEc
CZkixR0APKAsU62gneigAAWZCHZbxhd310yjIk4dKhURGKXJiA5OE3F4/TJvV272
tkvA1mff0XTJCHHLTKGnCeakPdFbQH2dpyaxV58A1IIcx15IKgE=
=AOKb
-----END PGP SIGNATURE-----

--Sig_/Z9nrlx=IYKvMt1IYn2OQ9CU--
