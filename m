Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EBF3DEAE3
	for <linux-cxl@vger.kernel.org>; Mon, 19 Oct 2026 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397396; cv=none; b=Ia5m34Prnedl0OSxiT6PiW8FXUJVaE1usDvJoi5Q+et4dHrjzzv2tnmPJcrwYQNtxZr1pdgCMsv6DkbCRR/C73MsNEi0bWd5F638MSoecKBDp8YtlwAJJHOWlzctTRmK5kCUtC1ZUri9jmXEJrkM3+ZRIsgRVz9OOgipyJ09+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397396; c=relaxed/simple;
	bh=gaNUjpSmTugYD6mmwofTS1EMtujtsMuRH3KcnKqFUpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6uLQUjiHZqOgtO7DoU5ZiBV8Pqs39lu0IR8jUkM7t8aq3sWvVu9oYmKfREEM/cl+iLPwpoF3BH3n9Yffekm7eSl02YX/XZnDytZp/x66ltUZlcaxmpNWWxFeEMaff2p8VRh7P7sLu50atlLcBDhcNhbK2Yq9apAXjsyJ/O7IJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VC3b2vtn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VC3b2vtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792397394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references;
	bh=IaoiWq5RwFbEFX82Ws7GGNe6sahRjgrmqS5d8bY6QEY=;
	b=VC3b2vtnvBW8UPDP4sndNhr60E3+oWMeFBJjXVRqRky91SKv0hSdgQupE5GKUcg2aFhiX5
	aK61cLPOfcI+2IHDi0KUEgbBLzkzs2K8jH5i/vF5u9QqYSttJjR7LxTWOd8HjB0VHY5vwd
	9CknzUamN7omRoR9CL8NzhiNMSnmtEI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-zV76_5wBO4i8uEPk00E6Bg-1; Mon,
 19 Oct 2026 08:09:51 +0000
X-MC-Unique: zV76_5wBO4i8uEPk00E6Bg-1
X-Mimecast-MFC-AGG-ID: zV76_5wBO4i8uEPk00E6Bg_1792397389
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7420118001E1;
	Mon, 19 Oct 2026 08:09:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C7791800642;
	Mon, 19 Oct 2026 08:09:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D191621E6A04; Mon, 19 Oct 2026 10:09:46 +0200 (CEST)
Resent-To: michael.roth@amd.com, jic23@kernel.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, elena.ufimtseva@oracle.com,
 jag.raman@oracle.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, linux-cxl@vger.kernel.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 19 Oct 2026 10:09:46 +0200
Resent-Message-ID: <87qzhm1585.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
  Michael Roth <michael.roth@amd.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Peter Maydell <peter.maydell@linaro.org>,
  Elena Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  Jonathan Cameron <jic23@kernel.org>,
  qemu-arm@nongnu.org,  linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 45/62] include: add QEMU_REPEAT helper macro
In-Reply-To: <20260911-qom-qapi-v5-45-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 11 Sep 2026 20:35:19 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
	<20260911-qom-qapi-v5-45-7732a55b7760@redhat.com>
Date: Mon, 19 Oct 2026 09:45:32 +0200
Message-ID: <87fqy22kwz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: QAo-3mcHVtLuWxERtsiD9t7s3lltQq4vrpp4iWtbW38_1792397389
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Introduce a macro used in following commit, and convert a few existing
> candidates. Inspired by a similar macro in Linux kernel/trace/bpf_trace.c
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

[...]

> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 7e6819f670b5..84c3ff05cfb8 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -496,22 +496,11 @@ static size_t vfu_object_bar_rw(PCIDevice *pci_dev,=
 int pci_bar,
>                                   buf, count, is_write);                 =
       \
>      }                                                                   =
       \
> =20
> -VFU_OBJECT_BAR_HANDLER(0)
> -VFU_OBJECT_BAR_HANDLER(1)
> -VFU_OBJECT_BAR_HANDLER(2)
> -VFU_OBJECT_BAR_HANDLER(3)
> -VFU_OBJECT_BAR_HANDLER(4)
> -VFU_OBJECT_BAR_HANDLER(5)
> -VFU_OBJECT_BAR_HANDLER(6)
> +QEMU_REPEAT(PCI_NUM_REGIONS, VFU_OBJECT_BAR_HANDLER)
> =20
> +#define VFU_OBJECT_BAR_HANDLER_PTR(BAR_NO) vfu_object_bar##BAR_NO##_hand=
ler,

scripts/checkpatch.pl

    ERROR: Macros with complex values should be enclosed in parenthesis

False positive, I guess.  Can't see offhand how to avoid it.

>  static vfu_region_access_cb_t *vfu_object_bar_handlers[PCI_NUM_REGIONS] =
=3D {
> -    &vfu_object_bar0_handler,
> -    &vfu_object_bar1_handler,
> -    &vfu_object_bar2_handler,
> -    &vfu_object_bar3_handler,
> -    &vfu_object_bar4_handler,
> -    &vfu_object_bar5_handler,
> -    &vfu_object_bar6_handler,
> +    QEMU_REPEAT(PCI_NUM_REGIONS, VFU_OBJECT_BAR_HANDLER_PTR)
>  };
> =20
>  /**

[...]

