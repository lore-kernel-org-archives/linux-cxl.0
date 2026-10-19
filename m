Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379284F55D2
	for <linux-cxl@vger.kernel.org>; Mon, 19 Oct 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415144; cv=none; b=IyKrA6nO7aoP1hoPl75YV/yVzZ7mTcAJYZBjOUBd7dfXaTbCtQRRSBr23Lo9KW1NkcELydgWergCHyKAsC8+M3MGVw8z4WA1iqJqcUy+H6ZrnnxXWsbBEW95knQMGasCnSVczgA28qNP1DN9jvSjceH2E7RMuA2R99Ra5/xZA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415144; c=relaxed/simple;
	bh=fnnt63K2KwmPfOJczQqK+KNTgrdQ0oI1taZyeLC5XOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+w5RZzWR6rb1ZL1LmsC72NmPYOyegHhwGfJoNCSX5sZliYHHvMtdPFzOeJ81tjasCLsYwQHeSOJ6pTnQRJnW3P6QR3AhNPmbmq6R6SqVRE2v67uAXlgFXmy00EMJ6PH8ZXHlbxJcR7YCOLdDDIHr6tkub5C0mUrWP3yUTn/NxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCj2qjgm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCj2qjgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792415141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72WhN+GdbzueK9mUa46K3l0+K84OOoKCzg3hXS4R5TE=;
	b=MCj2qjgmxIUuEia9Mq6DoiReHj/0qLLsWr3KJc971YnQKgfZHtOUZsgCyyJFCwcBoK+7nN
	Dv3uJdRh5HjvEjPRQjpbSKj69nWMjSnOtM/IuOIFX4PlsdT5the7EJAa491r28O51drnAY
	0b3SnTpeV438jQNcye+fiUYmeZHmcPU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-VBlEnvoDOcGZ2wnIaLwvqw-1; Mon,
 19 Oct 2026 13:05:37 +0000
X-MC-Unique: VBlEnvoDOcGZ2wnIaLwvqw-1
X-Mimecast-MFC-AGG-ID: VBlEnvoDOcGZ2wnIaLwvqw_1792415132
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 004D31954B3B;
	Mon, 19 Oct 2026 13:05:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF4A47E2;
	Mon, 19 Oct 2026 13:05:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 706FD21E6A04; Mon, 19 Oct 2026 15:05:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
  Michael Roth <michael.roth@amd.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Alberto Garcia <berto@igalia.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Jonathan Cameron <jic23@kernel.org>,  Elena
 Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  John Levon <john.levon@nutanix.com>,  Thanos
 Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
  Marcelo Tosatti <mtosatti@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
  David Hildenbrand <david@kernel.org>,  Cornelia Huck <cohuck@redhat.com>,
  Eric Farman <farman@linux.ibm.com>,  Matthew Rosato
 <mjrosato@linux.ibm.com>,  qemu-block@nongnu.org,
  linux-cxl@vger.kernel.org,  kvm@vger.kernel.org,  qemu-s390x@nongnu.org
Subject: Re: [PATCH v5 17/62] qom: convert struct properties to QAPI-aware
 registration
In-Reply-To: <20260911-qom-qapi-v5-17-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 11 Sep 2026 20:34:51 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
	<20260911-qom-qapi-v5-17-7732a55b7760@redhat.com>
Date: Mon, 19 Oct 2026 15:05:28 +0200
Message-ID: <87ik2xzvqf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: FK-OPJZAzrTSYOAI223bnEjT1KGfqRtTsRjO0KimPM8_1792415132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Convert all callers of object_property_add() and
> object_class_property_add() that register struct-typed properties with
> QAPI visitor-based getters/setters to use object_property_add_qapi() and
> object_class_property_add_qapi() instead.
>
> This replaces the manual string type name with a reference to the
> generated QAPITypeInfo constant, enabling QMP introspection to report
> accurate QAPI type information for struct properties. Existing
> getters/setters are preserved unchanged.
>
> The cxl-fmw property type is corrected from "CXLFixedMemoryWindow"
> (not a real QAPI type) to "CXLFixedMemoryWindowOptions".
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  authz/list.c              |  2 +-
>  block/throttle-groups.c   |  5 +++--
>  chardev/char-socket.c     |  3 ++-
>  hw/core/machine.c         | 11 +++++++----
>  hw/cxl/cxl-host.c         |  4 +++-
>  hw/remote/vfio-user-obj.c |  5 +++--
>  hw/vfio-user/pci.c        |  5 +++--
>  target/i386/cpu.c         | 11 ++++++++---
>  target/i386/kvm/tdx.c     |  4 +++-
>  target/s390x/cpu-system.c |  4 +++-
>  10 files changed, 36 insertions(+), 18 deletions(-)
>
> diff --git a/authz/list.c b/authz/list.c
> index 363b2ee12c98..ed3d346004c2 100644
> --- a/authz/list.c
> +++ b/authz/list.c
> @@ -128,7 +128,7 @@ qauthz_list_class_init(ObjectClass *oc, const void *d=
ata)
>          .set =3D qauthz_list_prop_set_policy,
>      ));
> =20
> -    object_class_property_add(oc, "rules", "QAuthZListRule",
> +    object_class_property_add_qapi(oc, "rules", &QAuthZListRule_type_inf=
o,
>                                qauthz_list_prop_get_rules,
>                                qauthz_list_prop_set_rules,
>                                NULL, NULL);

docs/devel/style.rst (for what it's worth):

    In case of function, there are several variants:

    * 4 spaces indent from the beginning
    * align the secondary lines just after the opening parenthesis of the f=
irst

    For example:

    .. code-block:: c

        do_something(x, y,
            z);

        do_something(x, y,
                     z);

        do_something(x, do_another(y,
                                   z));

Thoughts?

[...]

