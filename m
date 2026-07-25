Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA521767D
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988029; cv=none; b=DK8HbMboG729W98dwYGpQ7szswdbmBeqgaK+v9f/1v2cYYB37GGAFRbSvIx1JthwtDVST2NQF3zufLJhZ52kLKDzXTnz2dCSjRVvcKKmFHumTSliQgGSk3ZxMn1laLpAKSQE4I2rkJJPcJ1wg7SrCUgm2HI+aV7yG4j43wfCUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988029; c=relaxed/simple;
	bh=i6aG/+m9MW1saa93R8BeXUCOlYyxsLU70+4agx0S76E=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=fsaP0NACzAc0MHAhSmPNAPzK62bT4cbng5sn2Y08mgye/p/964W0qoNllL5iYClfJbwdUvIjHgA+ur7jGTZ+JeqkIa0xaKQuNXKB6lcMAyHj4YdJP7+AzlfJbBU0pkVqJ/MYi13bfYI51u/4uP4Ei4voCrA+8sI1deuaKimxUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqGbzuhD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqGbzuhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784988027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2QvmsMbZq6HxVKl0q+cNVQuSts58ffZqW4LJ1FpBXw=;
	b=UqGbzuhDK8CuOaIKfsxOGpRhU4WIDasGozZreeaRUI958bseDJXPldhuQ/cTMcfFePCtrp
	Ya4b+TWCPHs/DkN0GOsT01eSTdh3HJ43LgqY81z443LQBiAH1BtgpzERrnCiPkh7IQLUix
	B1Rm5sorr71Nqy3jnFbXD/bRuUMWOHA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-UzdeTn1GNI61I7j9eW2ppw-1; Sat,
 25 Jul 2026 10:00:23 -0400
X-MC-Unique: UzdeTn1GNI61I7j9eW2ppw-1
X-Mimecast-MFC-AGG-ID: UzdeTn1GNI61I7j9eW2ppw_1784988021
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFFE319560BF;
	Sat, 25 Jul 2026 14:00:19 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E67D180058C;
	Sat, 25 Jul 2026 14:00:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 18:00:02 +0400
Subject: [PATCH 1/7] hw/display/virtio-gpu-rutabaga: zero-init capset info
 response
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260725-fix2-v1-1-5c9a6ce7b96a@redhat.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
In-Reply-To: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=i6aG/+m9MW1saa93R8BeXUCOlYyxsLU70+4agx0S76E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFl6n3FXGeka2GqVWAr7DfN3yU1cJsO+7fyG
 ZCXBCbeNSqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZQAKCRDa6OEJdZac
 5TQNEAC5lnm/WyMGw3mTaHRhojYRmDb8uhNbmYbgBkqHeUv2WmoN/gszPoL7+u0gtJZ8Hl15Sjr
 zj90sK1yghWmWEQ+7+eMB/bLoU2rtYGmba6QJ9UevBGIjx4Cy0n2UXjr4naa1T4zCXDNa93Qt5w
 Ebjiks3mliMcjA50OHg4HfJtPr54eXPM6eWtLnFxx/wrvR6qCCAo3dxcy6GFsx/iBP6H61DT0EN
 PiqtIqgaN58UEC2ouYpcEyaxW9BcDwRj4MIAx8W2gu9iHhUZSmjhCHpY/Vu8uuUPdBSN8sOiMwt
 WzalKhKY5FWgD26ZQdy7UhksxSVAlIEytj+cd1ArTwsp7hYYYcbE+Y3Y1U8npYOndfey9oz+YU4
 CrK7Gkz4wDHoFqvSk0otXOiOnDjXBmv4ma2EbardiBYqwTrXBmnjqroWjiqAJvcBEQfVKYlvjph
 hMH7TVO1IcGnbWPHtktoG1yKWy46bJ73vHIhJnW+/lCEj4bES7p5oDevwSL6BjFUD2u99b+duHq
 BH0wSpvZAP+ZykceZlfHfg4o96sj+spXrDdW1CcoLzpl2pjnm7abvM+P8UG7E6yTOyRp3fawqo8
 3kGT3he1dKmZlcxitCW1h7aLM+/1LhMHJwu/iYmz7LZPvBd2FMTCYiSbPh0ggzoSkde6YqPbx/c
 foJ/baWu3fdsvsg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: NgGo5HXux2giEbmwwj8C4W55Y24B-L_XEcugPNbrDKo_1784988021
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

rutabaga_cmd_get_capset_info() only fills in capset_id,
capset_max_version and capset_max_size before sending the response to
the guest. The remaining fields of struct virtio_gpu_resp_capset_info,
including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
stack garbage and leaked to the guest, including host pointers useful
for an ASLR bypass.

Zero the response first, matching virgl_cmd_get_capset_info().

Not a real risk thanks to -ftrivial-auto-var-init=zero.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3609
Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Reported-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 4d7d7b245929..95a19eed7eda 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -555,6 +555,8 @@ rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
 
     VIRTIO_GPU_FILL_CMD(info);
 
+    memset(&resp, 0, sizeof(resp));
+
     result = rutabaga_get_capset_info(vr->rutabaga, info.capset_index,
                                       &resp.capset_id, &resp.capset_max_version,
                                       &resp.capset_max_size);

-- 
2.55.0

