Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493460;
	b=PkB9FZzrBszpVllwboMRB+qogzYskuRSTfzUxvekvI3YEENXvZce4dQh2V+Nflc63re6
	 Jw1mENld0rxIoZmVPo3HgmChE5Y9Jr70PgVw5H8680qjgRRujuAg3Yci1bYdvY6Q9Sqk/
	 yrrd6wlEyMEfkQbFXOhus1wImvPmD6FYiXF4gGOLHhullNbce25p6RyFPnbVsO6GMDXvA
	 wsXWgTnulDkNBzj3vnxcKH6UDdzKtaHGgW6Ey8kjYe7188Fv86Z09JFK8FS3H0NpWUfuI
	 oooqfPhXDg76QqilP+l4F1oD/rYjeTB7X6pZIKBDREQYQeQmmByExYtxKBF8Lsk0k+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493460;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=UI1oOgUjr2C09/42flcMtOL/qp5uyR5nZp4lNbzLhMM=;
	b=1G+ldAzt/iTLNm131/qEZhv0cs430F1WT4HAQzwQ1PaKMFUcJjSi0zsre7gfrnonfG+z
	 iEfWBxZX2AZJHROcUirN54YJfNPjkwQG96otZFbYRtGC/K6+mAKc8fHD+0/px7S9BC7G3
	 AjGs0CLyNCUqQE9EXwDemOGTugvFFOWJ4x8OIQpsW05WZIqhrFtWoW6YkV2hEsew5kBgy
	 OJi9bdRjdq8qZEDf2fEhQWFsSr6tF0GjExIH7cD6PwNB11fZchN2n/kK5yqtvSVCrITHy
	 VI+W442dHrotX9KSYGuoqVJKMEz0da7HfsY9vyAOUj48woAap9mvOUfGhsyCTC7NF2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BbsGheBv;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56081606A31D
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56081606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BbsGheBv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UI1oOgUjr2C09/42flcMtOL/qp5uyR5nZp4lNbzLhMM=;
	b=BbsGheBvc2ShzHurKHTiC9XiWovHZD5Dto1yrH8A9xonMm7sSbTmA4Z5NTl8MxfnaBCbwC
	0fo9e3hTzk/rAC3cc1r1ZBrjR2L7Kq7o7OpOeIXaQ/3Idxkr5OYtNLJQqCbYwqDCCZnyXC
	Vqf0gKxCcTehLLuSEmEcrK+/K8I3sVI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-CrQK4deUNTad1FIQ0b2Mjg-1; Tue,
 20 Oct 2026 06:50:50 -0400
X-MC-Unique: CrQK4deUNTad1FIQ0b2Mjg-1
X-Mimecast-MFC-AGG-ID: CrQK4deUNTad1FIQ0b2Mjg_1792493447
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3CE01954194;
	Tue, 20 Oct 2026 10:50:46 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3F891956088;
	Tue, 20 Oct 2026 10:50:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:07 +0400
Subject: [PATCH v7 50/65] hw/gpio/pca955x: convert pin/led property to
 QAPI-aware enum
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-50-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=18182;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/T2C1S926CriVURvy1V0b555zaz9n8rbWnuo7vsoD8E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10Zc/MyZjsGCSo1em3rwgIrcI3my50hA6ArKg
 XY6eoCG8OOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXAAKCRDa6OEJdZac
 5WerD/9ns1InvVwABVk1Ky8TEmeyVcSbJeoQ9nMEgwkTHwjl6qy+A2E4Cjjp5FAOPp7vSLb1FVz
 ZXMI8PMPr4JEzANxAvBYlnRoEGPZWbJJLf767vjKnD8shLpXlXhnvL9alhzbcNGyXIkOUELKEGB
 P4mM2H4U9fK8o3tgDeq4H0SEsbQVrgGpKJ27O9m7ISTwXbHhZ2ZBBLm4DQguo/iU1/kJ5Rgp9DD
 vlZFzPj+Ou/pP1RN7vLgr+2VKDcu6BSThcuqpOnYT/g7z14okU02LhRu/+3E4siXVFTnLUMc9kP
 W36YY8NastaSyEKVu3Y8pSvJiiTk0LClt+biOdN06lDl5EeoLSyczPFdPrfibyX5qyqz35XJfvf
 SLw9HQCVxO9o+9cACPrRm31c8Q0pHEpDEs6p12Jk0YhG7LSCGOL3smAcPDNSwqA8VE6ea5paj7z
 74Tr28SsZAahFvb95zAmoYTZmaobkL/CnrvnQJDmnJgaA2EBKeYSj2COvwCHP1zz6zzbY2ySv6g
 vCVkOGb3B2VMQVrjOQg68OiiNgB9U+5qCBJkyzHVLXTebevqwzcbalEFgE2RHHzL3tbBq/ecpRG
 HWNo20RnvrQvpG9pxYxhGmGni7lpSdZzHnm/WuJYaHbEgwLAwAAvYXD1+eTxTM6Lx7smAXkFK2l
 xSsQ6OzWsYMuwNw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: qq211xevRHmH_tHeAxF6NtrEahi8lY0Dyz2IVkKfT6o_1792493447
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Replaces the runtime-parsed visitor-based QOM property accessors with
compile-time per-pin/per-LED accessor functions using QEMU_REPEAT.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/gpio/pca9552.c | 205 +++++++++++++++++++++---------------------------------
 hw/gpio/pca9554.c | 136 ++++++++++++++----------------------
 2 files changed, 131 insertions(+), 210 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 16741c22dea3..0a007bbbe4ac 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-visit-machine.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "trace.h"
 #include "qom/object.h"
 
@@ -354,33 +355,6 @@ static int pca955x_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA955xClass *k = PCA955X_GET_CLASS(obj);
-    PCA955xState *s = PCA955X(obj);
-    int led, rc, reg;
-    Pca9552LedState state;
-
-    rc = sscanf(name, "led%2d", &led);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (led < 0 || led >= k->pin_count) {
-        error_setg(errp, "%s: invalid led %s", __func__, name);
-        return;
-    }
-    /*
-     * Get the LSx register as the qom interface should expose the device
-     * state, not the modeled 'input line' behaviour which would come from
-     * reading the INPUTx reg
-     */
-    reg = PCA9552_LS0 + led / 4;
-    state = (pca955x_read(s, reg) >> ((led % 4) * 2)) & 0x3;
-    visit_type_Pca9552LedState(v, name, &state, errp);
-}
-
 /*
  * Return an LED selector register value based on an existing one, with
  * the appropriate 2-bit state value set for the given LED number (0-3).
@@ -391,97 +365,8 @@ static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int state)
                 ((state & 0x3) << (led_num << 1));
 }
 
-static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA955xClass *k = PCA955X_GET_CLASS(obj);
-    PCA955xState *s = PCA955X(obj);
-    int led, rc, reg, val;
-    Pca9552LedState state;
-
-    if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
-        return;
-    }
-    rc = sscanf(name, "led%2d", &led);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (led < 0 || led >= k->pin_count) {
-        error_setg(errp, "%s: invalid led %s", __func__, name);
-        return;
-    }
-
-    reg = PCA9552_LS0 + led / 4;
-    val = pca955x_read(s, reg);
-    val = pca955x_ledsel(val, led % 4, state);
-    pca955x_write(s, reg, val);
-}
-
 static void pca955x_set_ext_state(PCA955xState *s, int pin, int level);
 
-static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA955xClass *k = PCA955X_GET_CLASS(obj);
-    PCA955xState *s = PCA955X(obj);
-    int pin, rc;
-    uint8_t input_reg;
-    Pca9552PinState state;
-
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= k->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
-
-    /*
-     * Report the raw pin logic level; polarity inversion is a read-time
-     * transform applied to the INPUT register, not to the pin state itself.
-     */
-    input_reg = PCA9535_INPUT0 + (pin / 8);
-    state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
-    visit_type_Pca9552PinState(v, name, &state, errp);
-}
-
-static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA955xClass *k = PCA955X_GET_CLASS(obj);
-    PCA955xState *s = PCA955X(obj);
-    int pin, rc;
-    Pca9552PinState state;
-    uint8_t config_reg;
-
-    if (!visit_type_Pca9552PinState(v, name, &state, errp)) {
-        return;
-    }
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= k->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
-
-    /* Only input-configured pins can be driven by an external device. */
-    config_reg = PCA9535_CONFIG0 + (pin / 8);
-    if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
-        qemu_log_mask(LOG_UNIMP,
-                      "%s: pin %d is configured as output, ignoring set\n",
-                      s->description, pin);
-        return;
-    }
-
-    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_STATE_LOW);
-}
-
 static const VMStateDescription pca9552_vmstate = {
     .name = "PCA9552",
     .version_id = 0,
@@ -536,26 +421,92 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
     s->len = 0;
 }
 
+/*
+ * Get the LSx register as the qom interface should expose the device
+ * state, not the modeled 'input line' behaviour which would come from
+ * reading the INPUTx reg
+ */
+#define DEFINE_LED_ACCESSORS(n)                                              \
+static int prop_get_led##n(Object *obj, Error **errp)                        \
+{                                                                            \
+    PCA955xState *s = PCA955X(obj);                                          \
+    uint8_t reg = PCA9552_LS0 + (n) / 4;                                     \
+    return (pca955x_read(s, reg) >> (((n) % 4) * 2)) & 0x3;                  \
+}                                                                            \
+static void prop_set_led##n(Object *obj, int val, Error **errp)              \
+{                                                                            \
+    PCA955xState *s = PCA955X(obj);                                          \
+    uint8_t reg = PCA9552_LS0 + (n) / 4;                                     \
+    uint8_t old = pca955x_read(s, reg);                                      \
+    pca955x_write(s, reg, pca955x_ledsel(old, (n) % 4, val));                \
+}
+
+QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, DEFINE_LED_ACCESSORS)
+
+#define LED_ENUM_PROP(n) {                                              \
+    .name = "led" #n,                                                   \
+    .default_value = -1,                                                \
+    .qapi_type = &Pca9552LedState_type_info,                            \
+    .get = prop_get_led##n,                                             \
+    .set = prop_set_led##n,                                             \
+},
+
+static const QapiEnumProp led_enum_props[] = {
+    QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, LED_ENUM_PROP)
+};
+
+/*
+ * Report the raw pin logic level; polarity inversion is a read-time
+ * transform applied to the INPUT register, not to the pin state
+ * itself.
+ */
+#define DEFINE_PIN_ACCESSORS(n)                                              \
+static int prop_get_pin##n(Object *obj, Error **errp)                        \
+{                                                                            \
+    PCA955xState *s = PCA955X(obj);                                          \
+    uint8_t input_reg = PCA9535_INPUT0 + (n) / 8;                            \
+    return (s->regs[input_reg] >> ((n) % 8)) & 0x1;                          \
+}                                                                            \
+static void prop_set_pin##n(Object *obj, int val, Error **errp)              \
+{                                                                            \
+    PCA955xState *s = PCA955X(obj);                                          \
+    uint8_t config_reg = PCA9535_CONFIG0 + (n) / 8;                          \
+    /* Only input-configured pins can be driven by an external device */     \
+    if (!((s->regs[config_reg] >> ((n) % 8)) & 0x1)) {                       \
+        qemu_log_mask(LOG_UNIMP,                                             \
+                      "%s: pin %d configured as output, ignoring set\n",     \
+                      s->description, (n));                                  \
+        return;                                                              \
+    }                                                                        \
+    pca955x_set_ext_state(s, (n), val != PCA9552_PIN_STATE_LOW);             \
+}
+
+QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, DEFINE_PIN_ACCESSORS)
+
+#define PIN_ENUM_PROP(n) {                                              \
+    .name = "pin" #n,                                                   \
+    .default_value = -1,                                                \
+    .qapi_type = &Pca9552PinState_type_info,                            \
+    .get = prop_get_pin##n,                                             \
+    .set = prop_set_pin##n,                                             \
+},
+
+static const QapiEnumProp pin_enum_props[] = {
+    QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, PIN_ENUM_PROP)
+};
+
 static void pca955x_initfn(Object *obj)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
 
     assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
+    /* TODO: use array/list instead of individual QAPI enum properties */
     for (int ix = 0; ix < k->pin_count; ix++) {
-        char *name;
-
         if (k->has_led_support) {
-            /* LED variant: expose the LED selector state as led%d. */
-            name = g_strdup_printf("led%d", ix);
-            object_property_add(obj, name, "Pca9552LedState",
-                                pca955x_get_led, pca955x_set_led, NULL, NULL);
+            object_property_add_qapi_enum(obj, &led_enum_props[ix]);
         } else {
-            /* GPIO variant: expose the pin logic level as pin%d. */
-            name = g_strdup_printf("pin%d", ix);
-            object_property_add(obj, name, "Pca9552PinState",
-                                pca955x_get_pin, pca955x_set_pin, NULL, NULL);
+            object_property_add_qapi_enum(obj, &pin_enum_props[ix]);
         }
-        g_free(name);
     }
 }
 
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index e4eddc829ef7..f2a5b94a36d8 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -18,7 +18,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-visit-machine.h"
-#include "qapi/visitor.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "trace.h"
 #include "qom/object.h"
 
@@ -151,83 +151,60 @@ static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
     }
 }
 
-static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA9554State *s = PCA9554(obj);
-    int pin, rc;
-    Pca9554PinState state;
-
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
-
-    /*
-     * Report the physical pin level. The input register is kept in sync by
-     * pca9554_update_pin_input(): output pins mirror the OUTPUT register and
-     * input pins reflect the externally driven (or pulled-up) level, so it
-     * holds the wire level regardless of the configured direction.
-     */
-    state = (s->regs[PCA9554_INPUT] >> pin) & 0x1;
-    visit_type_Pca9554PinState(v, name, &state, errp);
+/*
+ * Report the physical pin level. The input register is kept in sync
+ * by pca9554_update_pin_input(): output pins mirror the OUTPUT
+ * register and input pins reflect the externally driven (or
+ * pulled-up) level, so it holds the wire level regardless of the
+ * configured direction.
+ */
+#define DEFINE_PIN_ACCESSORS(n)                                              \
+static int prop_get_pin##n(Object *obj, Error **errp)                        \
+{                                                                            \
+    PCA9554State *s = PCA9554(obj);                                          \
+    return (s->regs[PCA9554_INPUT] >> (n)) & 0x1;                            \
+}                                                                            \
+static void prop_set_pin##n(Object *obj, int val, Error **errp)              \
+{                                                                            \
+    PCA9554State *s = PCA9554(obj);                                          \
+    if (s->hw_dir) {                                                         \
+        if (!((s->regs[PCA9554_CONFIG] >> (n)) & 0x1)) {                     \
+            qemu_log_mask(LOG_UNIMP,                                         \
+                          "%s: pin %d configured as output,"                 \
+                          " ignoring set\n",                                 \
+                          s->description, (n));                              \
+            return;                                                          \
+        }                                                                    \
+        pca9554_set_ext_state(s, (n), val != PCA9554_PIN_STATE_LOW);         \
+    } else {                                                                 \
+        /* Legacy behavior: force output mode and drive */                   \
+        uint8_t mask = 0x1 << (n);                                           \
+        int v = pca9554_read(s, PCA9554_OUTPUT);                             \
+        if (val == PCA9554_PIN_STATE_LOW) {                                  \
+            v &= ~mask;                                                      \
+        } else {                                                             \
+            v |= mask;                                                       \
+        }                                                                    \
+        pca9554_write(s, PCA9554_OUTPUT, v);                                 \
+        v = pca9554_read(s, PCA9554_CONFIG);                                 \
+        v &= ~mask;                                                          \
+        pca9554_write(s, PCA9554_CONFIG, v);                                 \
+    }                                                                        \
 }
 
-static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA9554State *s = PCA9554(obj);
-    int pin, rc, val;
-    uint8_t mask;
-    Pca9554PinState state;
+QEMU_REPEAT(PCA9554_PIN_COUNT, DEFINE_PIN_ACCESSORS)
 
-    if (!visit_type_Pca9554PinState(v, name, &state, errp)) {
-        return;
-    }
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
+#define PIN_ENUM_PROP(n) {                                              \
+    .name = "pin" #n,                                                   \
+    .default_value = -1,                                                \
+    .qapi_type = &Pca9554PinState_type_info,                            \
+    .get = prop_get_pin##n,                                             \
+    .set = prop_set_pin##n,                                             \
+},
 
-    if (s->hw_dir) {
-        /* Warn and ignore if the guest has configured this pin as output */
-        if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
-            qemu_log_mask(LOG_UNIMP,
-                          "%s: pin %d is configured as output, "
-                          "ignoring external set\n",
-                          s->description, pin);
-            return;
-        }
-        /* Drive the external input level */
-        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_STATE_LOW);
-    } else {
-        /* Legacy behavior: force output mode and drive */
-        /* First, modify the output register bit */
-        val = pca9554_read(s, PCA9554_OUTPUT);
-        mask = 0x1 << pin;
-        if (state == PCA9554_PIN_STATE_LOW) {
-            val &= ~(mask);
-        } else {
-            val |= mask;
-        }
-        pca9554_write(s, PCA9554_OUTPUT, val);
-
-        /* Then, clear the config register bit for output mode */
-        val = pca9554_read(s, PCA9554_CONFIG);
-        val &= ~mask;
-        pca9554_write(s, PCA9554_CONFIG, val);
-    }
-}
+static const QapiEnumProp pin_enum_props[] = {
+    QEMU_REPEAT(PCA9554_PIN_COUNT, PIN_ENUM_PROP)
+};
 
 static const VMStateDescription pca9554_vmstate = {
     .name = "PCA9554",
@@ -264,16 +241,9 @@ static void pca9554_reset(DeviceState *dev)
 static void pca9554_initfn(Object *obj)
 {
     PCA9554Class *pc = PCA9554_GET_CLASS(obj);
-    int pin;
 
-    for (pin = 0; pin < pc->pin_count; pin++) {
-        char *name;
-
-        name = g_strdup_printf("pin%d", pin);
-        object_property_add(obj, name, "Pca9554PinState",
-                            pca9554_get_pin, pca9554_set_pin,
-                            NULL, NULL);
-        g_free(name);
+    for (int pin = 0; pin < pc->pin_count; pin++) {
+        object_property_add_qapi_enum(obj, &pin_enum_props[pin]);
     }
 }
 

-- 
2.56.0.116.g6de20f6092dc

