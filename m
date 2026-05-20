Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62A3CBE75
	for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271335; cv=none; b=sSAzc4DrMiDoub2IjFLWDIR02oNc3jYfShwTBDSkdfUnuvvRPxYQo7KuI4nhVgqsC3/VpAiU4pVWDzx1YCPrm7TzwsxRrhVxhyaEfJYzTxETVQoXuAU6jxkK5f+2bAlyA8HAH8TA8msurYQcOLfVDpBJgThenDVS8csOgYc/ack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271335; c=relaxed/simple;
	bh=BrAYckMkGuCbqi6yYFpD9gyknF+3NjxqFvS5vXkR2vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izr3KfkurgMv7r//tVDRwnCMEGnH2eG0ADO0eh0E9IK4jg2Oa3nfKxYowcd7/i8Rt4A9fEdelpSK36NjHhXknmjb681EU8yFKTbCitMOYxQda0b6QHl6AXGypXEJtSwlVIUxpao5T59sE7ZTktz9IL/NTwRlCyotOgzL8rfgkeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAV6e7fV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAV6e7fV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B6B1F00894;
	Wed, 20 May 2026 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779271333;
	bh=aIpug8Xhuvwvpey0104SYTmAB76CSl7Xcf+smxCd7OU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KAV6e7fVUzLr+qWMlhdMvFxRJBuKVN8eti6+y6RG3nDvabjVWQfjwa+pOwLanm/7j
	 ZLcARKwv44cN9VWrR3WOu2l00+w2eIuMdzXKf02VlQdTSUwTeE5Nv0yO8NiCKdzdYJ
	 QwVc+/e722LXnN+G5HPpQMdpohjoC92vwoPJoqPU3HJhHyHOYmiSpHHiq8bpap5qFr
	 AgsLHfNvvcyEAnzjkX4ncXbEwN5redUrGB5Mvse9SlmMg+nbSZ79t86AdjLmP4uyBp
	 MLek5ca3Qno8mmBXFt1ZvxIqGaaO8UpEoyZ0SR9wX3fLDc2BhHWbJp74Zt1eAurpPe
	 t1SYI82dwvp/A==
Date: Wed, 20 May 2026 11:02:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Lant <joshualant@gmail.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 02/10] qdev/qbus: Allow hidden devices to be
 busless on QEMU startup
Message-ID: <20260520110205.428d0395@jic23-huawei>
In-Reply-To: <20260429135717.3048713-3-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
	<20260429135717.3048713-3-joshualant@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 14:48:36 +0100
Joshua Lant <joshualant@gmail.com> wrote:

> Extend the capability for hiding devices, introduced for virtio-net
> device in:
> 
> commit f3a8505656935cde32e28c1c6317f725084da1e0
> Author: Jens Freimann <jfreimann@redhat.com>
> Date:   Tue Oct 29 12:48:55 2019 +0100
> qdev/qbus: add hidden device support
> 
> Currently only endpoint devices can be hidden with a primary device
> and failover (known static configuration). However, looking at future
> composable systems, we see a need for hidden devices which have no associated
> bus upon boot. Move the check for hidden devices to before the bus
> search, and if it is hidden ignore the case where the device was
> described on the CLI without the "bus=" field.
> 
> This is motivated by a specific use-case: implementing the VCS
> command set, part of the CXL specification (CXL r3.2 Section 7.1.3). In
> this scenario a switch controlled by a Fabric Manager is able to change the
> virtual hierarchy of devices seen by a guest within a fixed physical system
> topology. The connecting bus is not known until runtime when
> a bind command is issued by the Fabric Manager.

So this comes back to the earlier comment on whether they are completely
hidden from a guest.  They aren't quite - we need to be able to
get to them via the MCTP or cxl-switch-cci (in band mailbox) paths.

Maybe we can solve that later without any compatibility problems
or by cheating and just searching hidden devices. I'm not sure.
> 
> Signed-off-by: Joshua Lant <joshualant@gmail.com>
> ---
>  system/qdev-monitor.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index f2aa400a77..b51dfe0645 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -650,6 +650,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>      DeviceState *dev;
>      BusState *bus = NULL;
>      QDict *properties;
> +    bool hide_device;
>  
>      driver = qdict_get_try_str(opts, "driver");
>      if (!driver) {
> @@ -663,6 +664,11 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>          return NULL;
>      }
>  
> +    /* Is the device hidden from the guest?
> +     * If yes, no need to find a default bus if none given...
> +     * Bus could be provided at runtime (i.e. in a switch)*/
> +    hide_device = qdev_should_hide_device(opts, from_json, errp);
> +
>      /* find bus */
>      path = qdict_get_try_str(opts, "bus");
>      if (path != NULL) {
> @@ -675,14 +681,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>                         driver, object_get_typename(OBJECT(bus)));
>              return NULL;
>          }
> -    } else if (dc->bus_type != NULL) {
> +    } else if (dc->bus_type != NULL && !hide_device) {
>          bus = qdev_find_default_bus(dc, errp);
>          if (!bus) {
>              return NULL;
>          }
>      }
>  
> -    if (qdev_should_hide_device(opts, from_json, errp)) {
> +    if (hide_device) {
>          if (bus && !qbus_is_hotpluggable(bus)) {
>              error_setg(errp, "Bus '%s' does not support hotplugging",
>                         bus->name);

