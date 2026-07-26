Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C373EDF76
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054581; cv=none; b=P14dqZdCVxdDSuL6ldc+WuBNcrfnwx9z2Dqx/dPzu5TXgjT9qDeNDdgdsUJMUwR1La84Ha6Fy+NzDDuH3GEtcyrngHSClYLHEXeS42K112NJX7wt/MQ31rx2h2CPJ3kXEF7PuL91uOHbUZyx1fU2Mr7TANhGrtZO7TTNmTqbaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054581; c=relaxed/simple;
	bh=dYscaZ10pzCOQoW4mv3UuRZEUhzWt/IaR5K2I+no5mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqrBsCyJRpw9ZQPMxZCKsH22F04VbKF0OQ/tO5zybOvrn8NDEoy1a7sArvJHuvYiYpYIsyE3dIOax2VaU+gawdOgk4iOAAQS2qtoS04l4eZ4tOuV29qbrF6ESxGNEz3N4TEHux93JhZkqjJSC1NaPmP9F6ZpUSOHYX1iUxCHkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=klv6+hs+; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="klv6+hs+"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q8Tbj8033700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 26 Jul 2026 17:29:37 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=eaMYy3YOaqsRdJ5DdcF4RsKABxoEZJAP/dzLLdBqc44=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1785054577; v=1;
        b=klv6+hs+UryjxdiAUDTjc5V/yv2vH9jS6OvszJdXTjpTadArE6W2T9Tu0xskw89m
         vMUqaFQuSf2JxA0VIZ2p8/MTeEQ6w/MTlZsRkGcylg/ZtQoiC7RFpXNIc667ow4O
         tAYoShhMi5XkLuy9iiCDzgQgs9et2qkxcJqT3kBSBmyREXOXs9PehJ8sJhYk1Zr/
         AN+yzn4NuggaM91HcZUcS/JprySpuB846RYsqT/yRHAB4DdVgfXLS4JNjZQERSLN
         l7mWwrFoCYzyfRFHvzUyqRkGPv3t7ZQN4+5eeblO+9t8sLxI2zA7waa1HHkBsH4C
         FFIBm3onY4HUom9DZ8Ip3w==
Message-ID: <f919e684-93ed-4eca-8ddc-785e69dd8add@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 17:29:37 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] Fix many -Werror=maybe-uninitialized
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
        Jonathan Cameron <jic23@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
        Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
        Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
        linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-3-5c9a6ce7b96a@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-fix2-v1-3-5c9a6ce7b96a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/07/25 23:00, Marc-André Lureau wrote:
> When compiled with -Og, gcc produces many false-positives
> gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).
> 
> We already use auto-var-init=zero, but better be explicit.

I'm kind of reluctant to describe it is more explicit and it is better. 
The variables causing the false positives do not contain a useful value 
until later assignments. Initializing them obscures the fact and 
suppresses useful warnings. This patch may serve as a workaround, but 
its scope should be minimized.

I think WITH_QEMU_LOCK_GUARD() should be fixed to explicitly tell that 
the block is unconditionally executed. Linux does so, for example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fcc22ac5baf06dd17193de44b60dbceea6461983
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/blkio.c                 |  4 ++--
>   block/qcow2.c                 |  2 +-
>   hw/cxl/cxl-host.c             |  2 +-
>   hw/scsi/scsi-disk.c           |  2 +-
>   hw/scsi/scsi-generic.c        |  4 ++--
>   hw/scsi/virtio-scsi.c         |  2 +-
>   io/net-listener.c             | 10 +++++-----
>   target/i386/cpu.c             |  3 ++-
>   target/i386/emulate/x86_mmu.c |  4 ++--
>   9 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/block/blkio.c b/block/blkio.c
> index d2ba2a4d58dc..f7cb6e0b57d4 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -278,7 +278,7 @@ static bool blkio_completion_fd_poll(void *opaque)
>   {
>       BlockDriverState *bs = opaque;
>       BDRVBlkioState *s = bs->opaque;
> -    int ret;
> +    int ret = -1;
>   
>       /* Just in case we already fetched a completion */
>       if (s->poll_completion.user_data != NULL) {
> @@ -559,7 +559,7 @@ static bool blkio_register_buf(BlockDriverState *bs, void *host, size_t size,
>       BDRVBlkioState *s = bs->opaque;
>       struct blkio_mem_region region;
>       BlkioMemRegionResult region_result;
> -    int ret;
> +    int ret = -1;
>   
>       /*
>        * Mapping memory regions conflicts with RAM discard (virtio-mem) when
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 19271b10a49f..639593d737c8 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -838,7 +838,7 @@ static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
>   static void coroutine_fn cache_clean_timer(void *opaque)
>   {
>       BDRVQcow2State *s = opaque;
> -    uint64_t wait_ns;
> +    uint64_t wait_ns = 0;
>   
>       WITH_QEMU_LOCK_GUARD(&s->lock) {
>           wait_ns = s->cache_clean_interval * NANOSECONDS_PER_SECOND;
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 7e744312f1d8..eba13c9e7cba 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
>       MemoryRegion *mr = NULL;
>       uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
>       MemoryRegion *direct_mr;
> -    g_autofree char *direct_mr_name;
> +    g_autofree char *direct_mr_name = NULL;

This fixes a real issue, not a false positive. An early return can 
trigger a cleanup on an uninitialized variable.

Regards,
Akihiko Odaki

>       unsigned int idx = state->hdm_decoder_idx;
>   
>       if (ct3d->hostvmem) {
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 1b0cce128c5e..82dc75cb7d10 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -3263,7 +3263,7 @@ static bool scsi_disk_pr_state_needed(void *opaque)
>   {
>       SCSIDiskState *s = opaque;
>       SCSIPRState *pr_state = &s->qdev.pr_state;
> -    bool ret;
> +    bool ret = false;
>   
>       if (!s->qdev.migrate_pr) {
>           return false;
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index 8999f3b72006..b044561ae2dd 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -553,8 +553,8 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
>       SCSIPRState *pr_state = &s->pr_state;
>       Error *local_err = NULL;
>       bool check_stale_key = true;
> -    uint64_t key;
> -    uint8_t resv_type;
> +    uint64_t key = 0;
> +    uint8_t resv_type = 0;
>   
>       /* Get the migrated PR state */
>       WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 6c7376801190..833f773d7f6c 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1093,7 +1093,7 @@ static void virtio_scsi_push_event(VirtIOSCSI *s,
>   
>   static void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
>   {
> -    bool events_dropped;
> +    bool events_dropped = false;
>   
>       WITH_QEMU_LOCK_GUARD(&s->event_lock) {
>           events_dropped = s->events_dropped;
> diff --git a/io/net-listener.c b/io/net-listener.c
> index 1fd0f6cb5ab8..8df19c35bd8f 100644
> --- a/io/net-listener.c
> +++ b/io/net-listener.c
> @@ -54,11 +54,11 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
>                                                 gpointer opaque)
>   {
>       QIONetListener *listener = QIO_NET_LISTENER(opaque);
> -    QIOChannelSocket *sioc;
> -    QIONetListenerClientFunc io_func;
> -    gpointer io_data;
> -    GMainContext *context;
> -    AioContext *aio_context;
> +    QIOChannelSocket *sioc = NULL;
> +    QIONetListenerClientFunc io_func = NULL;
> +    gpointer io_data = NULL;
> +    GMainContext *context = NULL;
> +    AioContext *aio_context = NULL;
>   
>       sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
>                                        NULL);
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5805d33ab92d..e9759ab25077 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7734,7 +7734,7 @@ static void x86_cpuid_get_avx10_version(Object *obj, Visitor *v,
>   static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
>                                            Error **errp)
>   {
> -    const AVX10VersionDefinition *def;
> +    const AVX10VersionDefinition *def = NULL;
>       CPUX86State *env = &cpu->env;
>   
>       if (!version) {
> @@ -7758,6 +7758,7 @@ static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
>           }
>       }
>   
> +    assert(def != NULL);
>       if (def->version < version) {
>           error_setg(errp, "avx10-version can be at most %d", def->version);
>           return false;
> diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
> index 8d4371467fd7..c1cb385b3228 100644
> --- a/target/i386/emulate/x86_mmu.c
> +++ b/target/i386/emulate/x86_mmu.c
> @@ -185,8 +185,8 @@ static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslat
>       int largeness = 0;
>       target_ulong cr3 = x86_read_cr(cpu, 3);
>       uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
> -    MMUTranslateResult res;
> -
> +    MMUTranslateResult res = 0;
> +
>       memset(pt, 0, sizeof(*pt));
>       top_level = gpt_top_level(cpu, pae);
>   
> 

