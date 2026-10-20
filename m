Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501215;
	b=tT9ygY5a8dyFBJWCvGcHB0IvUj2gkMDFqmOnUvoezaNQQFnqVae1uhdka7hvyiuRgeVD
	 kdBrmORQADf8k86F0dOeOJW7Ipaen0pik9oQlTFWHsSBomnMhl3wzavGN0thCXIq7r/8Q
	 lG2fwRUrdaszJ4jr64ObXfOlLTumnaFJJe+KylxVDbh+EjXEr4/QgUtl+U1IS6LS+P4l9
	 MhfHkFBBIRgeXSolh3iBhZ5CymFBQzyyolrHnWqpUhJ3SVNEW0tPaXa0HLTarsva+Xco6
	 WYhf+49l+wqTZn4LcgvOG4I2F+bglbcMRxTjkr9huxdcs0i+BvBE499Wac+Q8b6GtBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501215;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=IdGexhi468SGRjXz9icUeN0PDMP62iaPPGR0zWDcYQ8=;
	b=Vtq66H4Q8IrBMt0Oy67CBzDKGnqQt8XPcm+4lL44eONDjhhf65aZ0vAWK/ncVTuo8XO3
	 5E5LrC7BF77d1NItInrTsnwreOCukEbiyq6w8J+En1FSNKF7Ffr7pSIxq+YbwponFVIrq
	 2AGSWfWHD4zLMaKWEE+X6rAh2jgJtkT4t/AnXfRChbooW99MjOXxX1QCaQMzxxtvpftUq
	 2dx/lfbPToS8fLtheMjB/Me4nD0s4zdUWO2TvbvhUKHWZ4igBHiONumebSUvL/tjJehJg
	 OYhhKnoxlezLiXQs0W/CGAh2j1+eU4aFwT/e7MG3q0HV5PhyLN7PYRbVTGwE+dJ8d4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AhmC0tt1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31B606A325
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 13:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF31B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AhmC0tt1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792501214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdGexhi468SGRjXz9icUeN0PDMP62iaPPGR0zWDcYQ8=;
	b=AhmC0tt1au9vx21ad6HlGFnduDpl1mjKZ2GJ6Dgt2X8UyoTyUgltShwcP5dIhnzf7Xuewh
	sFSnLjkpdF+F1aVOwe8mjIJTxQad1zedOzb9q+7Ts34swIexdmn2RoqSEu4Ar0Z2f6+llx
	YUJcClztsqo9kff26r9M1umCURcDPUc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-SCYlsoeCN1mldLXfI2uYiQ-1; Tue,
 20 Oct 2026 13:00:08 +0000
X-MC-Unique: SCYlsoeCN1mldLXfI2uYiQ-1
X-Mimecast-MFC-AGG-ID: SCYlsoeCN1mldLXfI2uYiQ_1792501202
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABD0219539BD;
	Tue, 20 Oct 2026 13:00:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E085418002B1;
	Tue, 20 Oct 2026 12:59:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 65E3F21E6A04; Tue, 20 Oct 2026 14:59:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  John Snow
 <jsnow@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
  Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kostiantyn
 Kostiuk
 <kkostiuk@redhat.com>,  Eric Blake <eblake@redhat.com>,  David Hildenbrand
 <david@kernel.org>,  Igor Mammedov <imammedo@redhat.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Jason Wang <jasowangio@gmail.com>,
  Marcelo Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org,  Alberto
 Garcia <berto@igalia.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
  Zhao Liu <zhao1.liu@intel.com>,  Jonathan Cameron <jic23@kernel.org>,
  Junjie Cao <junjie.cao@intel.com>,  Anisa Su <anisa.su@samsung.com>,
  Elena Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  John Levon <john.levon@nutanix.com>,  Thanos
 Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
  Cornelia Huck <cohuck@redhat.com>,  Eric Farman <farman@linux.ibm.com>,
  Matthew Rosato <mjrosato@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
  qemu-block@nongnu.org,  linux-cxl@vger.kernel.org,
  qemu-s390x@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Sergio
 Lopez <slp@redhat.com>,  qemu-arm@nongnu.org,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Alistair Francis <alistair.francis@wdc.com>,
  Weiwei Li <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
  qemu-riscv@nongnu.org,  Song Gao <17746591750@163.com>,  Bibo Mao
 <maobibo@loongson.cn>,  Xianglai Li <lixianglai@loongson.cn>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Pedro Barbuda <pbarbuda@microsoft.com>,
  Mohamed Mediouni <mohamed@unpredictable.fr>,  Nicholas Piggin
 <npiggin@gmail.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,  Amit
 Machhiwal <amachhiw@linux.ibm.com>,  qemu-ppc@nongnu.org,  Zhang Chen
 <zhangckid@gmail.com>,  Li Zhijian <lizhijian@fujitsu.com>,  Alistair
 Francis <alistair@alistair23.me>,  Alexander Graf <graf@amazon.com>,
  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  zhenwei pi
 <zhenwei.pi@linux.dev>,  Ani Sinha <anisinha@redhat.com>,  Luc Michel
 <luc@lmichel.fr>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Jamin
 Lin
 <jamin_lin@aspeedtech.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Samuel
 Tardieu <sam@rfc1149.net>,  "Denis V. Lunev" <den@openvz.org>,  FangSheng
 Huang <FangSheng.Huang@amd.com>,  Tyrone Ting <kfting@nuvoton.com>,  Hao
 Wu <wuhaotsh@google.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  Jesper Devantier <foss@defmacro.it>,  Aditya Gupta
 <adityag@linux.ibm.com>,  Glenn Miles <milesg@linux.ibm.com>,  Conor
 Dooley <conor@kernel.org>,  Sebastian Huber
 <sebastian.huber@embedded-brains.de>,  Halil Pasic <pasic@linux.ibm.com>,
  Christian Borntraeger <borntraeger@linux.ibm.com>,  Jason Herne
 <jjherne@linux.ibm.com>,  Titus Rwantare <titusr@google.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Anthony PERARD
 <anthony@xenproject.org>,  Peter Xu <peterx@redhat.com>,  Chinmay Rath
 <rathc@linux.ibm.com>,  Hendrik Brueckner <brueckner@linux.ibm.com>,
  xen-devel@lists.xenproject.org,  Roman Bolshakov <rbolshakov@ddn.com>,
  Phil Dennis-Jordan <phil@philjordan.eu>,  Fam Zheng <fam@euphon.net>,
  Farhan Ali <alifm@linux.ibm.com>,  Alex Williamson <alex@shazbot.org>,
  Tao Tang <tangtao1634@phytium.com.cn>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Artyom Tarasenko
 <atar4qemu@gmail.com>,  Yoshinori Sato <yoshinori.sato@nifty.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Eric Auger <eric.auger@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v7 42/65] virtio-balloon: convert guest-stats property
 to QAPI type
In-Reply-To: <20261020-qom-qapi-v7-42-431a86b02b58@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 20 Oct 2026 14:45:59 +0400")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	<20261020-qom-qapi-v7-42-431a86b02b58@redhat.com>
Date: Tue, 20 Oct 2026 14:59:54 +0200
Message-ID: <87h5igplx1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 2HdkYVvhvrYzpGbuxg6NuRE44L8HHHOt8mQMdSoOzE0_1792501202
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Define VirtioBalloonStats and VirtioBalloonGuestStats QAPI struct types
> in the schema, replacing the hand-rolled visitor in balloon_stats_get_all=
()
> with a generated visit_type_VirtioBalloonGuestStats() call.
>
> The wire format is preserved: the JSON output from qom-get is identical
> to the previous hand-rolled visitor output.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/interop/virtio-balloon-stats.rst | 22 +--------
>  hw/virtio/virtio-balloon.c            | 84 ++++++++++++-----------------=
---
>  qapi/machine.json                     | 92 +++++++++++++++++++++++++++++=
++++++
>  3 files changed, 123 insertions(+), 75 deletions(-)
>
> diff --git a/docs/interop/virtio-balloon-stats.rst b/docs/interop/virtio-=
balloon-stats.rst
> index b9a6a6edb229..88d3271bbb02 100644
> --- a/docs/interop/virtio-balloon-stats.rst
> +++ b/docs/interop/virtio-balloon-stats.rst
> @@ -22,27 +22,7 @@ polling the guest's balloon driver for new stats in th=
e specified time
>  interval.
> =20
>  To retrieve those stats, clients have to query the guest-stats property,
> -which will return a dictionary containing:
> -
> -  * A key named 'stats', containing all available stats. If the guest
> -    doesn't support a particular stat, or if it couldn't be retrieved,
> -    its value will be -1. Currently, the following stats are supported:
> -
> -      - stat-swap-in
> -      - stat-swap-out
> -      - stat-major-faults
> -      - stat-minor-faults
> -      - stat-free-memory
> -      - stat-total-memory
> -      - stat-available-memory
> -      - stat-disk-caches
> -      - stat-htlb-pgalloc
> -      - stat-htlb-pgfail

Missing here:

          - stat-oom-kills
          - stat-alloc-stalls
          - stat-async-scans
          - stat-direct-scans
          - stat-async-reclaims
          - stat-direct-reclaims

Review note, not a request for anything.

> -
> -  * A key named last-update, which contains the last stats update
> -    timestamp in seconds. Since this timestamp is generated by the host,
> -    a buggy guest can't influence its value. The value is 0 if the guest
> -    has not updated the stats (yet).
> +which will return a VirtioBalloonGuestStats (see QAPI documentation).
> =20
>  It's also important to note the following:
> =20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 7ffbe48e5134..bfc75f5dfc72 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -29,6 +29,8 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-builtin-type-infos.h"
>  #include "qapi/qapi-events-machine.h"
> +#include "qapi/qapi-type-infos-machine.h"
> +#include "qapi/qapi-visit-machine.h"
>  #include "qapi/visitor.h"
>  #include "trace.h"
>  #include "qemu/error-report.h"
> @@ -170,33 +172,8 @@ static void balloon_deflate_page(VirtIOBalloon *ball=
oon,
>      }
>  }
> =20
> -/*
> - * All stats upto VIRTIO_BALLOON_S_NR /must/ have a
> - * non-NULL name declared here, since these are used
> - * as keys for populating the QDict with stats
> - */
> -static const char *balloon_stat_names[] =3D {
> -   [VIRTIO_BALLOON_S_SWAP_IN] =3D "stat-swap-in",
> -   [VIRTIO_BALLOON_S_SWAP_OUT] =3D "stat-swap-out",
> -   [VIRTIO_BALLOON_S_MAJFLT] =3D "stat-major-faults",
> -   [VIRTIO_BALLOON_S_MINFLT] =3D "stat-minor-faults",
> -   [VIRTIO_BALLOON_S_MEMFREE] =3D "stat-free-memory",
> -
> -   [VIRTIO_BALLOON_S_MEMTOT] =3D "stat-total-memory",
> -   [VIRTIO_BALLOON_S_AVAIL] =3D "stat-available-memory",
> -   [VIRTIO_BALLOON_S_CACHES] =3D "stat-disk-caches",
> -   [VIRTIO_BALLOON_S_HTLB_PGALLOC] =3D "stat-htlb-pgalloc",
> -   [VIRTIO_BALLOON_S_HTLB_PGFAIL] =3D "stat-htlb-pgfail",
> -
> -   [VIRTIO_BALLOON_S_OOM_KILL] =3D "stat-oom-kills",
> -   [VIRTIO_BALLOON_S_ALLOC_STALL] =3D "stat-alloc-stalls",
> -   [VIRTIO_BALLOON_S_ASYNC_SCAN] =3D "stat-async-scans",
> -   [VIRTIO_BALLOON_S_DIRECT_SCAN] =3D "stat-direct-scans",
> -   [VIRTIO_BALLOON_S_ASYNC_RECLAIM] =3D "stat-async-reclaims",
> -
> -   [VIRTIO_BALLOON_S_DIRECT_RECLAIM] =3D "stat-direct-reclaims",

Not missing here.

> -};
> -G_STATIC_ASSERT(G_N_ELEMENTS(balloon_stat_names) =3D=3D VIRTIO_BALLOON_S=
_NR);
> +/* Update VirtioBalloonStats QAPI type when new stats are added */
> +G_STATIC_ASSERT(VIRTIO_BALLOON_S_NR =3D=3D 16);

The assertion becomes awkward.

What about ...

> =20
>  /*
>   * reset_stats - Mark all items in the stats array as unset
> @@ -258,33 +235,31 @@ static void balloon_stats_get_all(Object *obj, Visi=
tor *v, const char *name,
>                                    void *opaque, Error **errp)
>  {
>      VirtIOBalloon *s =3D VIRTIO_BALLOON(obj);
> -    bool ok =3D false;
> -    int i;
> +    VirtioBalloonStats stats =3D {
> +        .stat_swap_in =3D s->stats[VIRTIO_BALLOON_S_SWAP_IN],
> +        .stat_swap_out =3D s->stats[VIRTIO_BALLOON_S_SWAP_OUT],
> +        .stat_major_faults =3D s->stats[VIRTIO_BALLOON_S_MAJFLT],
> +        .stat_minor_faults =3D s->stats[VIRTIO_BALLOON_S_MINFLT],
> +        .stat_free_memory =3D s->stats[VIRTIO_BALLOON_S_MEMFREE],
> +        .stat_total_memory =3D s->stats[VIRTIO_BALLOON_S_MEMTOT],
> +        .stat_available_memory =3D s->stats[VIRTIO_BALLOON_S_AVAIL],
> +        .stat_disk_caches =3D s->stats[VIRTIO_BALLOON_S_CACHES],
> +        .stat_htlb_pgalloc =3D s->stats[VIRTIO_BALLOON_S_HTLB_PGALLOC],
> +        .stat_htlb_pgfail =3D s->stats[VIRTIO_BALLOON_S_HTLB_PGFAIL],
> +        .stat_oom_kills =3D s->stats[VIRTIO_BALLOON_S_OOM_KILL],
> +        .stat_alloc_stalls =3D s->stats[VIRTIO_BALLOON_S_ALLOC_STALL],
> +        .stat_async_scans =3D s->stats[VIRTIO_BALLOON_S_ASYNC_SCAN],
> +        .stat_direct_scans =3D s->stats[VIRTIO_BALLOON_S_DIRECT_SCAN],
> +        .stat_async_reclaims =3D s->stats[VIRTIO_BALLOON_S_ASYNC_RECLAIM=
],
> +        .stat_direct_reclaims =3D s->stats[VIRTIO_BALLOON_S_DIRECT_RECLA=
IM],
> +    };

... putting it here?  This initializer also needs to be updated when
stats are added.

Another review note...  The kernel gives us an array of stats with
well-known indexes.  Since we "improved" on that interface, we need to
manually convert to struct.  Oh well.

> +    VirtioBalloonGuestStats guest_stats =3D {
> +        .last_update =3D s->stats_last_update,
> +        .stats =3D &stats,
> +    };
> +    VirtioBalloonGuestStats *argp =3D &guest_stats;
> =20
> -    if (!visit_start_struct(v, name, NULL, 0, errp)) {
> -        return;
> -    }
> -    if (!visit_type_int(v, "last-update", &s->stats_last_update, errp)) =
{
> -        goto out_end;
> -    }
> -
> -    if (!visit_start_struct(v, "stats", NULL, 0, errp)) {
> -        goto out_end;
> -    }
> -    for (i =3D 0; i < VIRTIO_BALLOON_S_NR; i++) {
> -        if (!visit_type_uint64(v, balloon_stat_names[i], &s->stats[i], e=
rrp)) {
> -            goto out_nested;
> -        }
> -    }
> -    ok =3D visit_check_struct(v, errp);
> -out_nested:
> -    visit_end_struct(v, NULL);
> -
> -    if (ok) {
> -        visit_check_struct(v, errp);
> -    }
> -out_end:
> -    visit_end_struct(v, NULL);
> +    visit_type_VirtioBalloonGuestStats(v, name, &argp, errp);
>  }
> =20
>  static void balloon_stats_get_poll_interval(Object *obj, Visitor *v,
> @@ -1037,7 +1012,8 @@ static void virtio_balloon_instance_init(Object *ob=
j)
>      s->free_page_hint_cmd_id =3D VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MI=
N;
>      s->free_page_hint_notify.notify =3D virtio_balloon_free_page_hint_no=
tify;
> =20
> -    object_property_add(obj, "guest-stats", "guest statistics",
> +    object_property_add_qapi(obj, "guest-stats",
> +                        &VirtioBalloonGuestStats_type_info,
>                          balloon_stats_get_all, NULL, NULL, NULL);

The @type reported by qom-list & friends changes from "guest statistics"
to "VirtioBalloonStats".  Such changes can be compatibility breaks.

We accept this one, because:

1. What "guest statistics" might mean was never documented.
   ObjectPropertyInfo's (flawed) comment covers only "primitive", child
   and link types, which misleadingly suggests values like this one
   don't exist.

2. We are not aware of anything relying on it, and we can't quite see
   why anything would want to rely on it.

3. @type is a bad interface we ought to deprecate in favor of
   @qapi-type.

All this needs to be noted in the commit message.  Perhaps even in
release notes.  I guess the latter will be easier if we do deprecate
@type.

> =20
>      object_property_add_qapi(obj, "guest-stats-polling-interval", &int_t=
ype_info,
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 9b145c635baf..34be3156270c 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1126,6 +1126,98 @@
>  ##
>  { 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
> =20
> +##
> +# @VirtioBalloonStats:
> +#
> +# VirtIO balloon device guest memory statistics.
> +#
> +# If the guest doesn't support a particular stat, or if it couldn't
> +# be retrieved, its value will be -1.

Please use the revised syntax for introductions:

    ##
    # @name: introduction, best to keep it brief, but you may continue it
    #     like this if necessary.  If your text need to refer to arguments
    #     / members, it's almost certainly not brief introduction anymore.
    #
    # Additional text can go here.  But do consider putting it further
    # down.

I apologize for the inconvenience.  We need this to eliminate certain
syntactic ambiguities that plagued the doc generator.  We'll need it
some more for the doc inliner.

> +#
> +# @stat-swap-in: The amount of memory that has been
> +#     swapped in (in bytes).

Wrap lines at column 70, please.

> +#
> +# @stat-swap-out: The amount of memory that has been
> +#     swapped out to disk (in bytes).
> +#
> +# @stat-major-faults: The number of major page faults
> +#     that have occurred.
> +#
> +# @stat-minor-faults: The number of minor page faults
> +#     that have occurred.
> +#
> +# @stat-free-memory: The amount of memory not being used
> +#     for any purpose (in bytes).
> +#
> +# @stat-total-memory: The total amount of memory available
> +#     (in bytes).
> +#
> +# @stat-available-memory: An estimate of how much memory is available
> +#     (in bytes) for starting new applications, without pushing the
> +#     system to swap.
> +#
> +# @stat-disk-caches: The amount of memory, in bytes, that can be
> +#     quickly reclaimed without additional I/O.  Typically these pages
> +#     are used for caching files from disk.
> +#
> +# @stat-htlb-pgalloc: The number of successful hugetlb page
> +#     allocations
> +#
> +# @stat-htlb-pgfail: The number of failed hugetlb page
> +#     allocations
> +#
> +# @stat-oom-kills: The number of OOM killer invocations
> +#
> +# @stat-alloc-stalls: The number of memory allocation stalls
> +#
> +# @stat-async-scans: The number of memory scanned asynchronously
> +#
> +# @stat-direct-scans: The number of memory scanned directly
> +#
> +# @stat-async-reclaims: The number of memory reclaimed asynchronously
> +#
> +# @stat-direct-reclaims: The number of memory reclaimed directly
> +#
> +# Since: 11.2

The actual interface, namely the device property, is much older (1.4?).
Do we care?  I'm not sure; this isn't part of QMP proper, it's for use
with QOM, where documentation has always been rather weak.

> +##
> +{ 'struct': 'VirtioBalloonStats',
> +  'data': {
> +    'stat-swap-in': 'uint64',
> +    'stat-swap-out': 'uint64',
> +    'stat-major-faults': 'uint64',
> +    'stat-minor-faults': 'uint64',
> +    'stat-free-memory': 'uint64',
> +    'stat-total-memory': 'uint64',
> +    'stat-available-memory': 'uint64',
> +    'stat-disk-caches': 'uint64',
> +    'stat-htlb-pgalloc': 'uint64',
> +    'stat-htlb-pgfail': 'uint64',
> +    'stat-oom-kills': 'uint64',
> +    'stat-alloc-stalls': 'uint64',
> +    'stat-async-scans': 'uint64',
> +    'stat-direct-scans': 'uint64',
> +    'stat-async-reclaims': 'uint64',
> +    'stat-direct-reclaims': 'uint64' } }

I don't like the "stat-" prefix, but we can't change that now.

> +
> +##
> +# @VirtioBalloonGuestStats:
> +#
> +# Guest statistics from the VirtIO balloon device.

Please use the revised syntax for introductions.

> +#
> +# @last-update: timestamp in seconds of the last stats
> +#     update from the guest (since this timestamp is generated
> +#     by the host, a buggy guest can't influence its value),
> +#     or 0 if no update has been received yet.

The original text is=20

  * A key named last-update, which contains the last stats update
    timestamp in seconds. Since this timestamp is generated by the host,
    a buggy guest can't influence its value. The value is 0 if the guest
    has not updated the stats (yet).

Threee sentences instead of one with a parenthesis.  I find this easier
to read.

> +#
> +# @stats: balloon memory statistics
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'VirtioBalloonGuestStats',
> +  'data': {
> +    'last-update': 'int',
> +    'stats': 'VirtioBalloonStats' } }
> +
>  ##
>  # @query-balloon:
>  #     Return information about the balloon device.

