Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F558282F3C
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988056; cv=none; b=Tel8BP89cHK9kAuztUVqXDKkIb8IvbGcIySf0xfJ1jlkbnaqmCiNbCd7myLW1ZW02Ct2+nZyzSN7uGL34idGkb+LgJxh1+YUSm3e9oRJOjmLUpZh1NlobZrCqrW1CVhqnIptDF4WNJO1rx5ARE6xBT+z6CWFiXUPNC+7ltlKQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988056; c=relaxed/simple;
	bh=sIBVNLsGCOna3Hd2Wy4wJ32pRVDvMFiol07f6gVUCMU=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=S1YkXsVA7T27Z+HoaTnYAW1WZpbjp1h5cT1yEzhDnQeV649iqTJQ4B42GVUp7npkNHzvXi3IiOiVBYRx37YHt7AfjBh+5n2/WlOJ+C6SIFkDYoDbJr9+IkYsVJBHxRIMViqrrSWsBpmZsjoY1WiIikUUYHLmVnHqn5JcF4f0bwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBDYGROv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBDYGROv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784988054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TTlcmViaW/jr0GgH0ehJXptanXZXliFPnYWOw9ddzY=;
	b=iBDYGROvXbG/JGSAFI1jXLS2PmdZ4qy7bBjz9TuNZ22oY0RQsXEwxZwmm5D0nuUDWqwnTm
	KzlICp+B796/sBxiukTCBBXgYTZkOfHzsYCWyHp8Lp3MRoouf2VQjXemsnG/25kix4cMIF
	Zwq7YZpwLGbsn+jSvso5K6BJ3jlZFYs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-WH263RbIOW2pp-hkSTLwBA-1; Sat,
 25 Jul 2026 10:00:48 -0400
X-MC-Unique: WH263RbIOW2pp-hkSTLwBA-1
X-Mimecast-MFC-AGG-ID: WH263RbIOW2pp-hkSTLwBA_1784988046
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56BDD19560BF;
	Sat, 25 Jul 2026 14:00:45 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 103BA1591;
	Sat, 25 Jul 2026 14:00:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 18:00:06 +0400
Subject: [PATCH 5/7] hw/core/machine: free machine->fdt in
 machine_finalize()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260725-fix2-v1-5-5c9a6ce7b96a@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=816;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sIBVNLsGCOna3Hd2Wy4wJ32pRVDvMFiol07f6gVUCMU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFmXwTAgpjiHXIDQP2F6pFQaQP0mTaHjVngT
 nIkCxm+8KOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZgAKCRDa6OEJdZac
 5d3oEAC1km7RbdV4XtCIKL8zA60V13xVkEzvtfqeWr/f9ALV+CqbVUN/wGdnv+8tnxmdT/YhVLx
 LifdyHD0stZaS22zhP+OIRFbMi/WKRzf7cYTyZsiyTpUm+ifAhxxpMUz/0u6wCy2f6EdJH9vDI9
 bkzHeqgDzYgcbCAFtcD9YOlJOm3BgLf9f3V3WZhmhPMWWAbXPy4NggSwma+M+I3J1M/atI/prZc
 W2ye63zNk41kC7h/41Kv6ieo7aDgJabx0Mz0b/rpjclfi4F+z5tQynn4b6/89PJC61VcHI91oWh
 XBxo5JhwG0g1hwnS5GK9vW8NJRr4Hg9TtLC+wpg72iVIOrAXqvBSF6RfELEurXtI8NcW6+eWHdp
 GFoNxVyTzfoavUfm4c54ZHNo2p3grXc2Wcp5d1TE2AEr5YzVqEV93zNkMnYEMElB4Xw556igetm
 KZ8m5o5RTd/HGzmOrbkhUGrUDaJJK295U+tJ0HKSwGb1IvFzMu2fSOf+VRfc8jTHPeMwcngOxQ/
 TM11p9NassLY1PbS4JmJ7MOr/DDvoMgY3UBELSzMS80dAmWb8CcLtx0crjPwJy8S/UEtUV2KwlP
 YO8ImD9hYIR6TtfFbJS60yMEIkMxIh/utU7BSF6o4hpgB0RrM5DDUS1bcm60Zj5/By8PUa3cZKc
 +HV5Oo7iwKniXAg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: hXUrwYHyog5JLZSyhPR5BcPcQH7grGH6984jECsue30_1784988046
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

machine->fdt is a plain g_malloc0() buffer (see create_device_tree())
that boards populate during MachineClass::init, but machine_finalize()
never freed it, unlike the other boot-time buffers (dtb, dumpdtb,
kernel_filename, ...). Free it for consistency.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 805148678d57..2b24d711d76f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1301,6 +1301,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->kernel_cmdline);
     g_free(ms->dtb);
     g_free(ms->dumpdtb);
+    g_free(ms->fdt);
     g_free(ms->dt_compatible);
     g_free(ms->firmware);
     g_free(ms->device_memory);

-- 
2.55.0

