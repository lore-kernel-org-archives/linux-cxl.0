Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493447;
	b=aXgRAoXbaSZBAR8WC/8h1ZrBDOE9Dwfr6utdFo3TbO3LFcxpLDz9fD3odjy/TYcepOiE
	 UP4s5PqX2Kf4d3LfL/F3Ahbr9PjuIGaqs8GYPPJ/1drlnmrfNgO47AfAPfcFd8/isRs6y
	 8F5WIHLldCfPMuiT3lSFtkn+XyVbZbJi8F2bpufbQbXTXoTQpq1/Wzs2FRb1SPul6/4Oi
	 Cwj0CoBWpqxHWC8SLfSfkEBpvsoF4M1SMQkTrElCKmJTApib+tVuh9/KB41i4VzBpChZc
	 uKVmh5b0ShAMoRUMAJshzGKw1xEaa9LmZI2REMxS+OhtTf+YqTuQpiVViOuHJKlNzyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493447;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=qwky9rRTw8oAHcuQCucWGoFZKa5DrHxcGAirH7r71y0=;
	b=rw37bZm16Rv5IrSpSgiE1xEsyzv/9f5siS5cziQBj2HoMqKaYJlecHJFlYELQxwt+XDx
	 2NBBTICsx4kTQLly2V7Av6j+/3F5ss6gCdAYUSQQaFZSNO8Rtdb+Brl35yB9epD1Deety
	 wUE2aV87OPI4/6gzWBor/vaCOhjRbYN6q6Xp45fOJ75qH2FvCSLerWa3ehjdOB1S3XVez
	 HP6u81izWEqWmfSm8n1TSq6iND0R/lR13ADvtlViXp+BEWtdR0bJbfph5sbz1JebgCOd/
	 +HkEHOewp5liOtf4AQFme1D6SUgM7JdeslLB+usYOTaSe05L6zpJ4vHqD74Z5MXiliw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="GR3l/Ie6";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AFB60A263A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5AFB60A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GR3l/Ie6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwky9rRTw8oAHcuQCucWGoFZKa5DrHxcGAirH7r71y0=;
	b=GR3l/Ie6K+OC3vkSsW3ExIGWTg3LbgEhhsM5RThDaE8csMnKuC+0DvIDdQY0UfQaeZiZs8
	UNbkukvG1mo9ycqktUyh4ro0ShsSPYM6t4dHLXsxcm0ZaOaFMBmtag8tNf+hgMCrPBStnh
	6iK7VXokjI2pzNlvVzOuMxY5v6CU03A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-Nf-L8n-POp-Ce5Q3K4PxmQ-1; Tue,
 20 Oct 2026 10:50:39 +0000
X-MC-Unique: Nf-L8n-POp-Ce5Q3K4PxmQ-1
X-Mimecast-MFC-AGG-ID: Nf-L8n-POp-Ce5Q3K4PxmQ_1792493435
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCEDD1800846;
	Tue, 20 Oct 2026 10:50:35 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AC121800643;
	Tue, 20 Oct 2026 10:50:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:05 +0400
Subject: [PATCH v7 48/65] hw/gpio/pca955x: use QAPI enums for led and pin
 properties
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-48-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15047;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=N091Shg2JHcPog3qa/YLAcE9hWHktbmtx29N6CIdf6Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZbJcXMYrMMXfr6szUmvgOQEfgL142iqUKd5
 YT6P0Nj+9+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWwAKCRDa6OEJdZac
 5Y1YEAC7Jjf0CNAuzPG1AoI6lNR1KKO2PD4cPsq5GQornKbm+OrFX6OdHOWVRiNy9yshRki5VHt
 y1UIfWtv5lVJuPfzIgFkDFdGGFqhZ5SX0+7I6l66rkSAPfQ9MYYZRi289uk6B2/arJH7Z5EFSKu
 iGlcGVQc9S4x3c/Kg1PtMxGhPvrXr76hSgtXid7nFld1/V2cAMfUm0M6Vr6yAb7Lul5Rp3r/caN
 cCC0tt6RzA9y+QM8LZnrQwFHhW7YHTh58dM4yXW5D3r/njyP8n3g0XYR1Jim0YTWx3z3PJWUMuE
 GxUCHw92BCWEbbwDilX7tms1L3KPst0YiZ7RL79JHKJb9xCAa6jVwQsv584lT0mhe1F1Ogonqkn
 NDkBOXyzBbvt79Pyn0stvJKsMla/XLny8sSa8o3wQZRTjd10guCFqF+CAbeX5XwrWLig/kslQgi
 jmNCSeNgdwl+kFZJQ3Glx9hD55WBtmbMVgakjAAfk2GP44aEKIPJ0c9xGjUtf4jdsQHElwlk3dc
 2IUG2VKR7vs+3NqwHkSYoCEk4c5P7Y42OJuYcXbXlU5s45IJDDbzPXqMdfHHkLd94cf/XE2iFHx
 E+2DhjzzNnw3c3Sr3XpRdw/jiWTPqEjBMSGCfy/ObEFvsn6BTov7EsqvWS6VL9qe04p2/+GTroa
 X35jn64JCYgndcQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: iZYN8cwsuPhIJBIAFCji04Zayosli1PbKDuVzx6-JuM_1792493435
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Replace hand-rolled string lookup tables with QAPI enums
Pca9552LedState and Pca955{2,4}PinState for the led%d and pin%d QOM
properties. This fixes the incorrect property type ("bool" for LEDs,
"str" for pins) and lets QAPI handle string-to-enum conversion in the
visitor, removing the manual string matching in the setters.

Add QEMU_BUILD_BUG_ON guards to ensure the QAPI-generated enum values
stay in sync with the hardware register encoding.

I kept Pca9552PinState & @Pca9554PinState separate types, because I
don't know if they could diverge. We could eventually merge those.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/gpio/pca9552.c | 82 +++++++++++++++++++++----------------------------------
 hw/gpio/pca9554.c | 39 ++++++++++----------------
 qapi/machine.json | 46 +++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 75 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 719149b7174b..16741c22dea3 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -23,7 +23,8 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
-#include "qapi/visitor.h"
+#include "qapi/qapi-types-machine.h"
+#include "qapi/qapi-visit-machine.h"
 #include "trace.h"
 #include "qom/object.h"
 
@@ -59,16 +60,15 @@ struct PCA955xClass {
 /*
  * Note:  The LED_ON and LED_OFF configuration values for the PCA955X
  *        chips are the reverse of the PCA953X family of chips.
+ *
+ * The QAPI enums must match the hardware register values.
  */
-#define PCA9552_LED_ON   0x0
-#define PCA9552_LED_OFF  0x1
-#define PCA9552_LED_PWM0 0x2
-#define PCA9552_LED_PWM1 0x3
-#define PCA9552_PIN_LOW  0x0
-#define PCA9552_PIN_HIZ  0x1
-
-static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
-static const char *pin_state[] = {"low", "high"};
+QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_ON != 0x0);
+QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_OFF != 0x1);
+QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_PWM0 != 0x2);
+QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_PWM1 != 0x3);
+QEMU_BUILD_BUG_ON(PCA9552_PIN_STATE_LOW != 0x0);
+QEMU_BUILD_BUG_ON(PCA9552_PIN_STATE_HIGH != 0x1);
 
 static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
 {
@@ -142,24 +142,24 @@ static void pca955x_update_pin_input(PCA955xState *s)
             uint8_t config = pca955x_pin_get_config(s, i);
 
             switch (config) {
-            case PCA9552_LED_ON:
+            case PCA9552_LED_STATE_ON:
                 /* Pin is set to 0V to turn on LED */
                 s->regs[input_reg] &= ~bit_mask;
                 break;
-            case PCA9552_LED_OFF:
+            case PCA9552_LED_STATE_OFF:
                 /*
                  * Pin is set to Hi-Z to turn off LED and
                  * pullup sets it to a logical 1 unless
                  * external device drives it low.
                  */
-                if (s->ext_state[i] == PCA9552_PIN_LOW) {
+                if (s->ext_state[i] == PCA9552_PIN_STATE_LOW) {
                     s->regs[input_reg] &= ~bit_mask;
                 } else {
                     s->regs[input_reg] |=  bit_mask;
                 }
                 break;
-            case PCA9552_LED_PWM0:
-            case PCA9552_LED_PWM1:
+            case PCA9552_LED_STATE_PWM0:
+            case PCA9552_LED_STATE_PWM1:
                 /* TODO */
             default:
                 break;
@@ -176,7 +176,7 @@ static void pca955x_update_pin_input(PCA955xState *s)
              */
             if (s->regs[config_reg] & bit_mask) {
                 /* Input mode - reflect external state */
-                if (s->ext_state[i] == PCA9552_PIN_LOW) {
+                if (s->ext_state[i] == PCA9552_PIN_STATE_LOW) {
                     s->regs[input_reg] &= ~bit_mask;
                 } else {
                     s->regs[input_reg] |= bit_mask;
@@ -360,7 +360,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int led, rc, reg;
-    uint8_t state;
+    Pca9552LedState state;
 
     rc = sscanf(name, "led%2d", &led);
     if (rc != 1) {
@@ -378,7 +378,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
      */
     reg = PCA9552_LS0 + led / 4;
     state = (pca955x_read(s, reg) >> ((led % 4) * 2)) & 0x3;
-    visit_type_str(v, name, (char **)&led_state[state], errp);
+    visit_type_Pca9552LedState(v, name, &state, errp);
 }
 
 /*
@@ -397,10 +397,9 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int led, rc, reg, val;
-    uint8_t state;
-    g_autofree char *state_str = NULL;
+    Pca9552LedState state;
 
-    if (!visit_type_str(v, name, &state_str, errp)) {
+    if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
         return;
     }
     rc = sscanf(name, "led%2d", &led);
@@ -413,16 +412,6 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    for (state = 0; state < ARRAY_SIZE(led_state); state++) {
-        if (!strcmp(state_str, led_state[state])) {
-            break;
-        }
-    }
-    if (state >= ARRAY_SIZE(led_state)) {
-        error_setg(errp, "%s invalid led state %s", __func__, state_str);
-        return;
-    }
-
     reg = PCA9552_LS0 + led / 4;
     val = pca955x_read(s, reg);
     val = pca955x_ledsel(val, led % 4, state);
@@ -437,7 +426,8 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int pin, rc;
-    uint8_t input_reg, state;
+    uint8_t input_reg;
+    Pca9552PinState state;
 
     rc = sscanf(name, "pin%2d", &pin);
     if (rc != 1) {
@@ -455,7 +445,7 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
      */
     input_reg = PCA9535_INPUT0 + (pin / 8);
     state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
-    visit_type_str(v, name, (char **)&pin_state[state], errp);
+    visit_type_Pca9552PinState(v, name, &state, errp);
 }
 
 static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
@@ -464,10 +454,10 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int pin, rc;
-    uint8_t state, config_reg;
-    g_autofree char *state_str = NULL;
+    Pca9552PinState state;
+    uint8_t config_reg;
 
-    if (!visit_type_str(v, name, &state_str, errp)) {
+    if (!visit_type_Pca9552PinState(v, name, &state, errp)) {
         return;
     }
     rc = sscanf(name, "pin%2d", &pin);
@@ -480,16 +470,6 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
-        if (!strcmp(state_str, pin_state[state])) {
-            break;
-        }
-    }
-    if (state >= ARRAY_SIZE(pin_state)) {
-        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
-        return;
-    }
-
     /* Only input-configured pins can be driven by an external device. */
     config_reg = PCA9535_CONFIG0 + (pin / 8);
     if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
@@ -499,7 +479,7 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_LOW);
+    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_STATE_LOW);
 }
 
 static const VMStateDescription pca9552_vmstate = {
@@ -529,7 +509,7 @@ static void pca9552_reset_hold(Object *obj, ResetType type)
     s->regs[PCA9552_LS2] = 0x55;
     s->regs[PCA9552_LS3] = 0x55;
 
-    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
+    memset(s->ext_state, PCA9552_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
     pca955x_update_pin_input(s);
 
     s->pointer = 0xFF;
@@ -549,7 +529,7 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
     s->regs[PCA9535_CONFIG0] = 0xFF;  /* All pins as inputs */
     s->regs[PCA9535_CONFIG1] = 0xFF;  /* All pins as inputs */
 
-    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
+    memset(s->ext_state, PCA9552_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
     pca955x_update_pin_input(s);
 
     s->pointer = 0xFF;
@@ -567,12 +547,12 @@ static void pca955x_initfn(Object *obj)
         if (k->has_led_support) {
             /* LED variant: expose the LED selector state as led%d. */
             name = g_strdup_printf("led%d", ix);
-            object_property_add(obj, name, "bool",
+            object_property_add(obj, name, "Pca9552LedState",
                                 pca955x_get_led, pca955x_set_led, NULL, NULL);
         } else {
             /* GPIO variant: expose the pin logic level as pin%d. */
             name = g_strdup_printf("pin%d", ix);
-            object_property_add(obj, name, "str",
+            object_property_add(obj, name, "Pca9552PinState",
                                 pca955x_get_pin, pca955x_set_pin, NULL, NULL);
         }
         g_free(name);
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 904698cdce85..e4eddc829ef7 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -16,6 +16,8 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-machine.h"
+#include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qom/object.h"
@@ -32,10 +34,8 @@ typedef struct PCA9554Class PCA9554Class;
 DECLARE_CLASS_CHECKERS(PCA9554Class, PCA9554,
                        TYPE_PCA9554)
 
-#define PCA9554_PIN_LOW  0x0
-#define PCA9554_PIN_HIZ  0x1
-
-static const char *pin_state[] = {"low", "high"};
+QEMU_BUILD_BUG_ON(PCA9554_PIN_STATE_LOW != 0x0);
+QEMU_BUILD_BUG_ON(PCA9554_PIN_STATE_HIGH != 0x1);
 
 static void pca9554_update_pin_input(PCA9554State *s)
 {
@@ -54,7 +54,7 @@ static void pca9554_update_pin_input(PCA9554State *s)
              * Input: the pin is Hi-Z with a pull-up, so it reads high
              * unless an external device drives it low.
              */
-            if (s->ext_state[i] == PCA9554_PIN_LOW) {
+            if (s->ext_state[i] == PCA9554_PIN_STATE_LOW) {
                 s->regs[PCA9554_INPUT] &= ~bit_mask;
             } else {
                 s->regs[PCA9554_INPUT] |= bit_mask;
@@ -156,7 +156,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
 {
     PCA9554State *s = PCA9554(obj);
     int pin, rc;
-    uint8_t state;
+    Pca9554PinState state;
 
     rc = sscanf(name, "pin%2d", &pin);
     if (rc != 1) {
@@ -175,7 +175,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
      * holds the wire level regardless of the configured direction.
      */
     state = (s->regs[PCA9554_INPUT] >> pin) & 0x1;
-    visit_type_str(v, name, (char **)&pin_state[state], errp);
+    visit_type_Pca9554PinState(v, name, &state, errp);
 }
 
 static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
@@ -183,10 +183,10 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
 {
     PCA9554State *s = PCA9554(obj);
     int pin, rc, val;
-    uint8_t state, mask;
-    g_autofree char *state_str = NULL;
+    uint8_t mask;
+    Pca9554PinState state;
 
-    if (!visit_type_str(v, name, &state_str, errp)) {
+    if (!visit_type_Pca9554PinState(v, name, &state, errp)) {
         return;
     }
     rc = sscanf(name, "pin%2d", &pin);
@@ -199,16 +199,6 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
-        if (!strcmp(state_str, pin_state[state])) {
-            break;
-        }
-    }
-    if (state >= ARRAY_SIZE(pin_state)) {
-        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
-        return;
-    }
-
     if (s->hw_dir) {
         /* Warn and ignore if the guest has configured this pin as output */
         if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
@@ -219,13 +209,13 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
             return;
         }
         /* Drive the external input level */
-        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_LOW);
+        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_STATE_LOW);
     } else {
         /* Legacy behavior: force output mode and drive */
         /* First, modify the output register bit */
         val = pca9554_read(s, PCA9554_OUTPUT);
         mask = 0x1 << pin;
-        if (state == PCA9554_PIN_LOW) {
+        if (state == PCA9554_PIN_STATE_LOW) {
             val &= ~(mask);
         } else {
             val |= mask;
@@ -264,7 +254,7 @@ static void pca9554_reset(DeviceState *dev)
     s->regs[PCA9554_POLARITY] = 0x0; /* No pins are inverted */
     s->regs[PCA9554_CONFIG] = pin_mask; /* All pins are inputs */
 
-    memset(s->ext_state, PCA9554_PIN_HIZ, pc->pin_count);
+    memset(s->ext_state, PCA9554_PIN_STATE_HIGH, pc->pin_count);
     pca9554_update_pin_input(s);
 
     s->pointer = 0x0;
@@ -280,7 +270,8 @@ static void pca9554_initfn(Object *obj)
         char *name;
 
         name = g_strdup_printf("pin%d", pin);
-        object_property_add(obj, name, "str", pca9554_get_pin, pca9554_set_pin,
+        object_property_add(obj, name, "Pca9554PinState",
+                            pca9554_get_pin, pca9554_set_pin,
                             NULL, NULL);
         g_free(name);
     }
diff --git a/qapi/machine.json b/qapi/machine.json
index 34be3156270c..46b6935ab0b8 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -416,6 +416,52 @@
 { 'enum': 'LostTickPolicy',
   'data': ['discard', 'delay', 'slew' ] }
 
+##
+# @Pca9552LedState:
+#
+# LED state for PCA9552.
+#
+# @on: LED on
+#
+# @off: LED off
+#
+# @pwm0: LED controlled by PWM0
+#
+# @pwm1: LED controlled by PWM1
+#
+# Since: 11.2
+##
+{ 'enum': 'Pca9552LedState',
+  'data': ['on', 'off', 'pwm0', 'pwm1'] }
+
+##
+# @Pca9552PinState:
+#
+# Pin state for PCA9552.
+#
+# @low: Pin low
+#
+# @high: Pin high
+#
+# Since: 11.2
+##
+{ 'enum': 'Pca9552PinState',
+  'data': ['low', 'high'] }
+
+##
+# @Pca9554PinState:
+#
+# Pin state for PCA9554.
+#
+# @low: Pin low
+#
+# @high: Pin high
+#
+# Since: 11.2
+##
+{ 'enum': 'Pca9554PinState',
+  'data': ['low', 'high'] }
+
 ##
 # @inject-nmi:
 #     Injects a Non-Maskable Interrupt (machine specific: for example

-- 
2.56.0.116.g6de20f6092dc

