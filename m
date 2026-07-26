Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162A31E845
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051088; cv=none; b=OkcV47ntr5NPaP9VTEZeDoVCZ7GmTHVHwjJis/vKneIAZp8pA0q40WATaWsTpprJaYzO88iBcmAHSbp46si3qacHZEI8sT4s3rXcH2SWJ2qiGloG98485eb67YLoS6pIuv9Uoc+t8oY5F+mKotfqqfYPGas58wQ2DyHILD6++P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051088; c=relaxed/simple;
	bh=oO4Ev5tDfSWn+w4fyc7iv7FY0D0uc562gxUU9IQsTFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTMAcuLJ2lEgIEy4DAj1Fw4OeWnzL6DQnajixifs+yLhjcdIELtzLGFgUfhGUXyZ4Js7ZYV/tU7SbztyfsvWlu869KomvkkQD2GwQyQCpAmE0oN2LNwyTSo1/n8n/SuHwn3ojXJglmNY+GSNLwOpZLa0uIG5j9kgVFgTIWqkdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=WHrt++18; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="WHrt++18"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q7VGDO015572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 26 Jul 2026 16:31:16 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=BNlYYOgHbLVXUDxrvxzaZs1qSsKTFjBZovszZv2GWkI=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1785051076; v=1;
        b=WHrt++18jB4TsCd63UCUijMYw40y9fUbv8Sn0XH4IyufzE0N78M3dMxZBcLwJwx2
         DF1tckUw7/iOg59c/KT9j3Q2w+oclMHZGS9hHRydYPMKEFvA2fWpbvGzw1EUzzTs
         lFSQcKHoOvON7A9mOEwKCr9ODbH/rroKtD06CCW7wOg2oXyqmTSPV1b5n7n1sXRj
         zBGOVSSDDUCraunp5nbx4rHdMZZoPVPvTZrImpwMG+vOhR9qyCNMv1olyKGwd9bo
         zENkYSZC18KymbQ1+FdQJ9CzVP5eVPyHLP8Tu3+2NYlwvYP6faARf62wQ5XDo9kt
         ctJ7IF7eUhApk1ot7Kwd/Q==
Message-ID: <7716c428-d479-4fd4-beec-bafbf5f3b439@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 16:31:15 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] qdev-monitor: drain RCU callbacks in
 qdev_device_add_from_qdict
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
 <20260725-fix2-v1-7-5c9a6ce7b96a@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-fix2-v1-7-5c9a6ce7b96a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/07/25 23:00, Marc-André Lureau wrote:
> qmp_device_add() and hmp_device_add() drain pending RCU callbacks after
> a failed device_add, since some bus teardown (e.g. bus_remove_child())
> is deferred to call_rcu(). -device on the command line reaches the same
> qdev_device_add_from_qdict() with errp pointing at error_fatal, whose
> ERRP_GUARD() exits before control returns to the caller, so the caller's
> drain_call_rcu() never runs.
> 
> Move the drain into qdev_device_add_from_qdict()'s own err_del_dev path
> so it always runs, and drop the now-redundant calls in qmp_device_add()
> and hmp_device_add().

It is reachable from virtio-net failover during guest feature 
negotiation. MMIO dispatch holds an RCU read lock at 
address_space_write(). If deferred primary creation fails, 
drain_call_rcu() waits for a grace period while its own thread remains a 
reader, deadlocking the VM.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   system/qdev-monitor.c | 33 ++++++++++-----------------------
>   1 file changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 00fed791cce1..884d407d60d4 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -746,6 +746,16 @@ err_del_dev:
>       object_unparent(OBJECT(dev));
>       object_unref(OBJECT(dev));
>   
> +    /*
> +     * Drain all pending RCU callbacks. This is done because some bus
> +     * related operations can delay a device removal (in this case this
> +     * can happen if device is added and then removed due to a
> +     * configuration error) to a RCU callback, but a caller might expect
> +     * the failed device to be fully torn down once this function
> +     * returns.
> +     */
> +    drain_call_rcu();
> +
>       return NULL;
>   }
>   
> @@ -870,18 +880,6 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>       DeviceState *dev;
>   
>       dev = qdev_device_add_from_qdict(qdict, true, errp);
> -    if (!dev) {
> -        /*
> -         * Drain all pending RCU callbacks. This is done because
> -         * some bus related operations can delay a device removal
> -         * (in this case this can happen if device is added and then
> -         * removed due to a configuration error)
> -         * to a RCU callback, but user might expect that this interface
> -         * will finish its job completely once qmp command returns result
> -         * to the user
> -         */
> -        drain_call_rcu();
> -    }
>       object_unref(OBJECT(dev));
>   }
>   
> @@ -1017,17 +1015,6 @@ void hmp_device_add(Monitor *mon, const QDict *qdict)
>       }
>       dev = qdev_device_add(opts, &err);
>       if (!dev) {
> -        /*
> -         * Drain all pending RCU callbacks. This is done because
> -         * some bus related operations can delay a device removal
> -         * (in this case this can happen if device is added and then
> -         * removed due to a configuration error)
> -         * to a RCU callback, but user might expect that this interface
> -         * will finish its job completely once qmp command returns result
> -         * to the user
> -         */
> -        drain_call_rcu();
> -
>           qemu_opts_del(opts);
>       }
>       object_unref(dev);
> 

