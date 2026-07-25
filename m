Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125021883E
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988025; cv=none; b=IGqOHtHAbX4BQcjcbotcqudOyDkcB5D7Yec5h73rH8OyAyt9AmiftZeTMPyx7uC1XXG/7lBanFm8eOGfB1zMvVerLQN6jayifDHSpVu2FT4CJIokCRu4KLV5TglCiOCFyrYpGJNN9rp1YtLrEHH8XjDc9OeFaDj2D+9jEnY0AyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988025; c=relaxed/simple;
	bh=lXenDq8VhO/CQidP59Zf/rUFYaTPbWRyfx8K5nWqM3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=C05+ecoFndiXlBLXFGk0zaYpXpNdU9QCgFbzKsDZevWQMyiJJsYv7s8JM8f4/qdzKs0eDBhiHO/hyg3MM1v4dF/OtohopevPa3XbHZkv31kGeHyk2CnGriXTW7wGUBeytTfHDwVSrvVYstjuql8t1EXHGHhRQUIkePn5t0lE/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N45Wh2GM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N45Wh2GM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784988022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sMkB49AJSC8avS3ylIG8JsgdXl7kTvtqlZEz34WRqRI=;
	b=N45Wh2GMWACS2XxHnbUzlzBoYz4nnh3clp2OgMepyxOsVA+zajK+i2ZYtXZJoqn6ZYFKGE
	dgydH83ltW/uXkjqZ8rJEXNvE4uakdP1ZuNxfuLby1yckLIo1gkIpJ7jlGq15mgNdHlzSQ
	lMhPzv3kcJFxThN9P9hgF13dmAWg1vM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-bru7P_bxMZaU1UpPJHRhFA-1; Sat,
 25 Jul 2026 10:00:18 -0400
X-MC-Unique: bru7P_bxMZaU1UpPJHRhFA-1
X-Mimecast-MFC-AGG-ID: bru7P_bxMZaU1UpPJHRhFA_1784988015
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 098BA18002D1;
	Sat, 25 Jul 2026 14:00:13 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3844180057F;
	Sat, 25 Jul 2026 14:00:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/7] Fixes for 11.1
Date: Sat, 25 Jul 2026 18:00:01 +0400
Message-Id: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNT3bTMCiNds1RTwxQjY0NzS5MkJaDSgqJUoDjYmOhYCL+4NCkrNbk
 EpFepthYArFUDzGgAAAA=
X-Change-ID: 20260725-fix2-6e51d231794b
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Haotian Jiang <jianghaotian.sunday@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lXenDq8VhO/CQidP59Zf/rUFYaTPbWRyfx8K5nWqM3A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFlzjhua2XJ9qKFuUZoGltAjqoD+6VC0jRdO
 mHxxqlOAlSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZQAKCRDa6OEJdZac
 5YblD/9uGULyoQvLf1S4WJHbuo6j884tmQ+nnyp+i6ItXJ8pYluxd/VhKRg0SZMRj/Zt9Z25ePm
 pysfYH/TVKngEmDXdzvSb+j83YE/emPoUJKSDiwmw7EwOXuBtMP9ZhTMa+lLf0WcvGHIYEhmEkX
 EfsVaRvIgOeriij+EV3QdVeZPhXf1gggfl+PWsvc00dXO0c6SRQ+y8/KmdIhPIH3Ijr6Gas/bwq
 WkrCTc1O2keHN075MIheEIUDFzFh2uW8eJzff5AA99Hkk2TUF1K1y05uZkfXfN58NCUWz4bwU0Q
 FbHz64oc4piO4d9R4/t0MXvjmWreLdsI0wjv/Fffv9AR2MO4dpIqo9DZSHLbnGOONamEsnOsSoc
 FtCQ9BnMcdXxPvCrd6idvwCObmXvXqR2R1F5l7RjOomUqgqaONpJyTPMLld/yfoQDV68p4SSBkL
 kPrknSWHRwAhFmQXiIV8jjZDbl83MLDi2ikGpUy66z0UbWVezBI7H68F7+REjdaXIXFFtLQ1NS2
 NQ4pngMIDMoFq49ONkI3u7TFPZ2Uh2TG4KlH17mqIx9wUbjea+VRDnU8FHYa7FNQr+JGzXKDHAe
 MtgvjsheQpp1B1KdhHU+37y9c0pRO3WrKFCGq7LQlm5kMTCj3fIZpf5+PkbJIsnlZJcdoRrDGNa
 jDaT6eprT55WC2g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 9UZWVNanGeBUsas-VdK0zIjqy5bQ-ZF6llacb7FAASg_1784988015
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi

Here are some assorted patches worth considering for the 11.1 freeze
bug-fix period.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (7):
      hw/display/virtio-gpu-rutabaga: zero-init capset info response
      block/blkio: fix error return value on getlength()
      Fix many -Werror=maybe-uninitialized
      hw/hexagon: fix machine->fdt leak in qom-test
      hw/core/machine: free machine->fdt in machine_finalize()
      migration/multifd: fix Error leak in multifd_recv_terminate_threads()
      qdev-monitor: drain RCU callbacks in qdev_device_add_from_qdict

 block/blkio.c                    |  8 ++++----
 block/qcow2.c                    |  2 +-
 hw/core/machine.c                |  1 +
 hw/cxl/cxl-host.c                |  2 +-
 hw/display/virtio-gpu-rutabaga.c |  2 ++
 hw/hexagon/virt.c                |  9 +--------
 hw/scsi/scsi-disk.c              |  2 +-
 hw/scsi/scsi-generic.c           |  4 ++--
 hw/scsi/virtio-scsi.c            |  2 +-
 io/net-listener.c                | 10 +++++-----
 migration/multifd.c              |  1 +
 system/qdev-monitor.c            | 33 ++++++++++-----------------------
 target/i386/cpu.c                |  3 ++-
 target/i386/emulate/x86_mmu.c    |  4 ++--
 14 files changed, 34 insertions(+), 49 deletions(-)
---
base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
change-id: 20260725-fix2-6e51d231794b

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>

