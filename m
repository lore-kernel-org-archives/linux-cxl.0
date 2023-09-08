Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC37EEB562
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Sep 2023 18:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbjIHSuO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Sep 2023 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbjIHSuO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Sep 2023 14:50:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413141FE5
        for <linux-cxl@vger.kernel.org>; Fri,  8 Sep 2023 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1694198881; x=1694803681; i=fan.ni@gmx.us;
 bh=GimAH50vXhARBTi+C4euhwGhrgTMsfErSCmhdWcKrv0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=opgMeXXt6KZy0JmQaAj/gYfV4Z1eVJyI3YFVu8oqA0Ib0npXqA0drvakGFU6jOL/i3NPPCz
 uuiHuxKCObDz9EEd/pX4YSmRMfZTQy3N51G6ruwz8Oye/26HOwkk96oPmA1FuRiYWfarId0DB
 lRdeNx/pb3q9D2SSvNs86NRPTeb0tDfsWyF8AfpCNQs6IeonqkvcCSq4RlJxxpytHu0fVV6W5
 bES8bBNHOKOi3ds3aUWCNrGwkRTKN8d2BYUNkd0Aeu/RS16wQsifqAehaFRuDwcNuWyrlTW7/
 /EO9SkFo4O+uiq+LtWvKgebUv14+CbXVeKwAUQ3uMJkHmxT3QxHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNKm0-1qFsVu0vQg-00OmCm; Fri, 08
 Sep 2023 20:48:00 +0200
Date:   Fri, 8 Sep 2023 11:47:49 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        dan.j.williams@intel.com, alison.schofield@intel.com,
        ayush.m55@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4] hw/cxl: Add get scan media capabilities cmd support
Message-ID: <ZPtsVWGFo+BwMVk2@debian>
References: <20230908073152.4386-1-dave@stgolabs.net>
 <20230908073152.4386-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908073152.4386-3-dave@stgolabs.net>
X-Provags-ID: V03:K1:x5tdV65kSUHvdguMNpXlsiss6aJk3ytSrZlPPOK5kJQoiMMR2jr
 6rNz4WZSTj0NCdzfp2U7Yx+U5svFGFYm8DfNXrhcRZgkIPeQxPjTzeYjukxhpGg4uzu7oLg
 +Zv0cv5VQd/HUi9Z9qMnNV5Bka102dn/dpVTm519GQZ7FoA/5/oRnd9ZitJ+K/zrddEtSog
 p4lQbvU1H/QPjRgGpq4DA==
UI-OutboundReport: notjunk:1;M01:P0:ylS4Kq6j7CQ=;J04bPjndAQBy8ScBb/BrJu3UOqI
 2GvSitPV2hJ7HymfKBb2EZfZfsAjx0w4rBZWZjyU4jhGPudVZQon5QhmIwAKAGJr7lL9OM2+V
 NehRW/Lc5iSoiuO4IvzxV9xBKHnPnsd7OJGHa61H0Wsp5VfD57fwmzgVspglVgnolejpuoeG6
 3s9gZ9FYO6W27Xu4M8kfAuJ4hCWfsQEdpB4lkyg2ROP6dTN1OCOsB7MeWeO2FvQ2sZYzhI8kR
 p+LZ3Euox580rXpiV/QO58dw+p0tL3Hk8ePiJFOolWcxPZ4fV9zBVtotafUtJox5d55re9s/R
 dZp5UOk0RhJEypZeteerXO8UFVbJ2M6ymA0qUvWLAIYNdjkXnDZ5QfT33sZ9Dnix6kadS2RFP
 J3t2VbLliU0hzyn/QMqyV+s/hw/omwrzEpSd+XBnnBWOg3qladw3/rlY7EcfBhXiTilPH6poA
 y2sEeIZtbXb++SIFUSp3esKOhPdyPxp9vahUrLBpTy0GxpOfIzrjhyj29WeWxcu5wulA0ZDm4
 Cn+SYtNUj4sSlJzAP9BXO7K6jxQPiv54N6k7QarYTFSK83cOeBpQhPL0/MrBCKmziwcbi1SJK
 idCU9yK3YXqagKsQwq5xvxbrDFZq3EtMfFbQ6wnXI04EkQH+HfnRqFkM4ERaqwT7HFKMXXe8X
 8j/W9jW5zExXJfMc9Owr2hs8mS5UXghew/AOV+tZ/SxAFA7u2ZzZ8DQlpiJ3bsWGTW3etZoyk
 IguNzydSbsNByvbn265loWT1PfREP+H31U2SN7SiETFzGetikfwxptWapyfHfFXrvty4Yz1i3
 oblMQ2ImPHyX0JP5cUTkjAJsOinz46u9Zo1AiWdUztKn1GSH/DTa41Ji80kTxuxK6EvXbtwFS
 1XCIoP5BFOeEOMTysrpHavZwWrU/ZjVwVlDxGhf8tBYNDMHScd2WI+UKzr/fMUrfQbz/E7ayJ
 bd6+GjEKErjyv6YX/rrH4ND3JnU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 08, 2023 at 12:31:50AM -0700, Davidlohr Bueso wrote:
> Use simple heuristics to determine the cost of scanning any given
> chunk, assuming cost is equal across the whole device, without
> differentiating between volatile or persistent partitions. This
> is aligned to the fact that these constraints are not enforced
> in respective poison query commands.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 53 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4e8651ebe2e9..3073222060ab 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -80,6 +80,7 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
>      DCD_CONFIG  =3D 0x48,
>          #define GET_DC_CONFIG          0x0
>          #define GET_DYN_CAP_EXT_LIST   0x1
> @@ -1174,6 +1175,56 @@ static CXLRetCode cmd_media_clear_poison(const st=
ruct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>
> +/*
> + * CXL r3.0 section 8.2.9.8.4.4: Get Scan Media Capabilities
> + */
> +static CXLRetCode
> +cmd_media_get_scan_media_capabilities(const struct cxl_cmd *cmd,
> +                                      uint8_t *payload_in,
> +                                      size_t len_in,
> +                                      uint8_t *payload_out,
> +                                      size_t *len_out,
> +                                      CXLCCI *cci)
> +{
> +    struct get_scan_media_capabilities_pl {
> +        uint64_t pa;
> +        uint64_t length;
> +    } QEMU_PACKED;
> +
> +    struct get_scan_media_capabilities_out_pl {
> +        uint32_t estimated_runtime_ms;
> +    } QEMU_PACKED;
> +
> +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> +    CXLDeviceState *cxl_dstate =3D &ct3d->cxl_dstate;
> +    struct get_scan_media_capabilities_pl *in =3D (void *)payload_in;
> +    struct get_scan_media_capabilities_out_pl *out =3D (void *)payload_=
out;
> +    uint64_t query_start;
> +    uint64_t query_length;
> +
> +    query_start =3D ldq_le_p(&in->pa);
> +    /* 64 byte alignment required */
> +    if (query_start & 0x3f) {
> +        return CXL_MBOX_INVALID_INPUT;

=46rom the spec, it is not clear to me whether we should return invalid
input or invalid PA.

Fan

> +    }
> +    query_length =3D ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
> +
> +    if (query_start + query_length > cxl_dstate->static_mem_size) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    /*
> +     * Just use 400 nanosecond access/read latency + 100 ns for
> +     * the cost of updating the poison list. For small enough
> +     * chunks return at least 1 ms.
> +     */
> +    stl_le_p(&out->estimated_runtime_ms,
> +             MAX(1, query_length * (0.0005L/64)));
> +
> +    *len_out =3D sizeof(*out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /*
>   * CXL r3.0 section 8.2.9.8.9.1: Dynamic Capacity Configuration
>   */
> @@ -1602,6 +1653,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] =
=3D {
>          cmd_media_inject_poison, 8, 0 },
>      [MEDIA_AND_POISON][CLEAR_POISON] =3D { "MEDIA_AND_POISON_CLEAR_POIS=
ON",
>          cmd_media_clear_poison, 72, 0 },
> +    [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] =3D { "MEDIA_AND_PO=
ISON_GET_SCAN_MEDIA_CAPABILITIES",
> +        cmd_media_get_scan_media_capabilities, 16, 0 },
>  };
>
>  static const struct cxl_cmd cxl_cmd_set_dcd[256][256] =3D {
> --
> 2.42.0
>
