Received: from cow.ash.relay.mailchannels.net (cow.ash.relay.mailchannels.net [23.83.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025EF2391A8
	for <linux-cxl@vger.kernel.org>; Thu,  5 Dec 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389237; cv=pass; b=ANMnYAPUZVt3PjQq9hUIMFJkg/zwsnhjUY93Ql1bNALEnHoOFsHH1A4erkgUv9UYoF0Bx9viyGjEjGGzuY60yQCnNFpBt8m8xgn9kWsMJ4s5Yrb3fQIn0nVUWJBqSDfKB8IkYz/c1MdaoVm8MYUN40C2z+eFmeE7HZsnlzJg36o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389237; c=relaxed/simple;
	bh=LrnMtsnK+yLXgjp1hsPxaJrqIaIKWqc0SNG1eoRz9ao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C7UX5p1/ORqOOcnhwqIqEfAV8BtPUNv7u5JimkefiHfG0VFgaWUA87y/5FyEgnfeaMQlOed5u21Y73ASf51sA8WVYvEtNB3kuckf9mER+WeNIO64662AqhgszJdDQCPjTTtKHql4f1HZobWraOR1DC3WR2aVLjSsMBhAtZZCUBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=IPUfYeLu; arc=pass smtp.client-ip=23.83.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="IPUfYeLu"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5F8678A2CFD;
	Thu,  5 Dec 2024 08:21:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a266.dreamhost.com (100-122-66-37.trex-nlb.outbound.svc.cluster.local [100.122.66.37])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E9B218A2B0A;
	Thu,  5 Dec 2024 08:21:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1733386871; a=rsa-sha256;
	cv=none;
	b=KU13E3eevZJLALdmagQyX3w1qWN/KmHJJ/z5kfeKPGiP/ybRkUt0vEQlJyo3EVEVHPWqNG
	Py4J3D/Rw9rq2wP/OJikkYXka5xQoWqDx45Z/I59TK74DiqAWtngipRDTPQ08SE4RTeW46
	Ii6v8Jvmi4GEo6Sz/+fgxTgfQk9YT9DJE3HdCk4Tqe2pTEN8hyExe0S5UWnnmeQ3+h+M4i
	UawHzZ57BQqL0DXNkOLC9AE03DSpfs6g87z9e4KV/Ao3lWhfc2R9+oaJ5t6ymsDaIDvuLf
	bIHuuGI89I0q9KVOS/QbvpxrIQpDxXZtywW0R0wCeIXwx6SVZROnYFeqo/95wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1733386871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=yWiB4CtU99NQvNqNyP7e+o94fl/RWDayysZotMMJro8=;
	b=QFn4etfrCsJIK4XBf1MVyBwDG+R7eMIrPYR901r7c3IudkJhl080oXNdh3VfPZVGWM5Tos
	qLQszpfJlJMJmdHnmPQZ90Z0+gAkjlfuOTWHebXtqMQswiEgSS1m3+mwyoZZHS6NwaTTDm
	DLi7/9upYBi71K+MbQQkXZ/yEy/52HmIDbRbCAq1R8opCQ1+rvHB6QYBCAZTzQ31c9tv3U
	Q//+rsIrLIbVA3gojAHT5MqzMBcEzlbFygnaxiTBW0BfjA46TR4b6ligDDgTO9SyTMYJ56
	Z78Bj3kVe6qduoXng/i1akxYmm5M/1c9ll/15S8uEBA08wv3eTl7/RcBDAoEMA==
ARC-Authentication-Results: i=1;
	rspamd-5d9d86ff64-d6xpt;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Drop: 59dd6f40730a48e8_1733386871263_144455398
X-MC-Loop-Signature: 1733386871263:1152345169
X-MC-Ingress-Time: 1733386871263
Received: from pdx1-sub0-mail-a266.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.66.37 (trex/7.0.2);
	Thu, 05 Dec 2024 08:21:11 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a266.dreamhost.com (Postfix) with ESMTPSA id 4Y3nQt0ntxzHp;
	Thu,  5 Dec 2024 00:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1733386870;
	bh=yWiB4CtU99NQvNqNyP7e+o94fl/RWDayysZotMMJro8=;
	h=From:To:Cc:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=IPUfYeLuJmnZECLhlgxooAoRfttGT4JaivUkKbsLzc4pUrqbRp5zVRDZ1uPsdq6S8
	 3HdOUoEG20DxmelcAM97RE1biLw6AUYUshIMJlmNdOq7XvAlKTqobW2uCuhW+Oj+tm
	 qKIUiaJuSkCAUZVdX04aBZ0d83FgT64+f3ckBr4ohSAOO+10J/bKnCl1WfJaLhUjuK
	 t6IygEkteTBQrtUJBJJXqobmZni9D9eDxc4FyaAgmEWuD8lrV0TVN7I1S8ETPRdIr0
	 i9oLcZQIMTLKziP2KUrvKHHJwXa/wC0ThhfFlmNgV/ug6zk3LtKHoGmwqgnjRkuup1
	 PvrV26N9n0F3A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	hch@infradead.org,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH] cxl: Support Global Persistent Flush (GPF)
Date: Thu,  5 Dec 2024 00:21:01 -0800
Message-Id: <20241205082101.1193038-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for GPF flows. It is found that the CXL specification
around this to be a bit too involved from the driver side. And while
this should really all handled by the hardware, this patch takes
things with a grain of salt.

- Dirty shutdown is not handled, and puts the responsibility on the
Admin to deal with any GPF failure - otherwise the kernel will just
keep using the device upon next boot. Hence no SetShutdownState DIRTY
upon memdev probe (and no need for clearing upon successful flush).

- As such, the driver will only update port timeouts throughout the
decode hierarchy, upon device probing and hot-remove. These timeouts
can be over-specified, particularly T1. Set the max and rely on
devices to minimize GPF response times to avoid the worst case wait
times that those timeouts imply.

- Energy budgeting is not supported.

Testing
-------

Qemu sets the DVSEC timeouts, for which the reading/writing flow
can be tested. Default values were modified[*] to spice things up:

(i) 2 direct-attached Type3 devices:

[    3.827398] cxl_pci:cxl_gpf_setup:859: cxl_pci 0000:0e:00.0: Device GPF timeout: 4000000 us (power needed: 51mW)
[    3.828308] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 2 us
[    3.829402] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:0c:00.0: new GPF Port phase 1 timeout: 70000000 us
[    3.830392] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 3 us
[    3.831038] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:00.0: new GPF Port phase 2 timeout: 4000000 us
[    3.832282] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 2 us
[    3.833338] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:0c:01.0: new GPF Port phase 1 timeout: 70000000 us
[    3.833948] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 3 us
[    3.834495] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:01.0: new GPF Port phase 2 timeout: 4000000 us
[    3.861131] cxl_pci:cxl_gpf_setup:859: cxl_pci 0000:0d:00.0: Device GPF timeout: 1000000 us (power needed: 51mW)
[    3.861769] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 70000000 us
[    3.862353] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 4000000 us
[    3.862963] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 70000000 us
[    3.863540] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 4000000 us

(ii) 2 CXL host bridges. Each host bridge has 2 CXL Root Ports, with the CXL Type3 device directly attached:

 +-[0000:0c]-+-00.0-[0d]----00.0
 |           \-01.0-[0e]----00.0
 \-[0000:de]-+-00.0-[df]----00.0
	     \-01.0-[e0]----00.0

[    6.878513] cxl_pci:cxl_gpf_setup:859: cxl_pci 0000:e0:00.0: Device GPF timeout: 5000000 us (power needed: 51mW)
[    6.878578] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:de:00.0: Port GPF phase 1 timeout: 2 us
[    6.879753] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:de:00.0: new GPF Port phase 1 timeout: 70000000 us
[    6.881505] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:de:00.0: Port GPF phase 2 timeout: 3 us
[    6.882830] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:de:00.0: new GPF Port phase 2 timeout: 5000000 us
[    6.884699] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:de:01.0: Port GPF phase 1 timeout: 2 us
[    6.885903] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:de:01.0: new GPF Port phase 1 timeout: 70000000 us
[    6.888307] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:de:01.0: Port GPF phase 2 timeout: 3 us
[    6.889476] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:de:01.0: new GPF Port phase 2 timeout: 5000000 us
[    6.995010] cxl_pci:cxl_gpf_setup:859: cxl_pci 0000:0d:00.0: Device GPF timeout: 1000000 us (power needed: 51mW)
[    6.995092] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 2 us
[    6.995106] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:0c:00.0: new GPF Port phase 1 timeout: 70000000 us
[    6.995117] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 3 us
[    6.995127] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:00.0: new GPF Port phase 2 timeout: 1000000 us
[    6.995200] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 2 us
[    6.995211] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:0c:01.0: new GPF Port phase 1 timeout: 70000000 us
[    6.995221] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 3 us
[    6.995232] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:01.0: new GPF Port phase 2 timeout: 1000000 us
[    7.461810] cxl_pci:cxl_gpf_setup:859: cxl_pci 0000:0e:00.0: Device GPF timeout: 3000000 us (power needed: 51mW)
[    7.463006] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 70000000 us
[    7.464746] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 1000000 us
[    7.465567] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:00.0: new GPF Port phase 2 timeout: 3000000 us
[    7.466534] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 70000000 us
[    7.467023] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 1000000 us
[    7.467478] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:01.0: new GPF Port phase 2 timeout: 3000000 us
[    7.504908] cxl_pci:cxl_gpf_setup:859: cxl_pci 0000:df:00.0: Device GPF timeout: 4000000 us (power needed: 51mW)
[    7.505400] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:de:00.0: Port GPF phase 1 timeout: 70000000 us
[    7.505857] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:de:00.0: Port GPF phase 2 timeout: 5000000 us
[    7.506339] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:de:01.0: Port GPF phase 1 timeout: 70000000 us
[    7.506794] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:de:01.0: Port GPF phase 2 timeout: 5000000 us

(iii) 4 Type3 devices below a CXL Switch:

[    4.667274] cxl_pci:cxl_gpf_setup:859: cxl_pci 0000:0f:00.0: Device GPF timeout: 2000000 us (power needed: 51mW)
[    4.668383] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:00.0: Port GPF phase 1 timeout: 1 us
[    4.671100] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:0e:00.0: new GPF Port phase 1 timeout: 70000000 us
[    4.672242] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:00.0: Port GPF phase 2 timeout: 2 us
[    4.674552] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:00.0: new GPF Port phase 2 timeout: 2000000 us
[    4.675750] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:01.0: Port GPF phase 1 timeout: 1 us
[    4.676895] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:0e:01.0: new GPF Port phase 1 timeout: 70000000 us
[    4.678213] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:01.0: Port GPF phase 2 timeout: 2 us
[    4.679514] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:01.0: new GPF Port phase 2 timeout: 2000000 us
[    4.680876] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:02.0: Port GPF phase 1 timeout: 1 us
[    4.682099] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:0e:02.0: new GPF Port phase 1 timeout: 70000000 us
[    4.683407] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:02.0: Port GPF phase 2 timeout: 2 us
[    4.684748] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:02.0: new GPF Port phase 2 timeout: 2000000 us
[    4.686150] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:03.0: Port GPF phase 1 timeout: 1 us
[    4.687396] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:0e:03.0: new GPF Port phase 1 timeout: 70000000 us
[    4.688601] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:03.0: Port GPF phase 2 timeout: 2 us
[    4.690070] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:03.0: new GPF Port phase 2 timeout: 2000000 us
[    4.692076] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 2 us
[    4.693138] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:0c:00.0: new GPF Port phase 1 timeout: 70000000 us
[    4.693149] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 3 us
[    4.694357] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:00.0: new GPF Port phase 2 timeout: 2000000 us
[    4.695776] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 2 us
[    4.697186] cxl_core:cxl_pci_update_gpf_port:1115: pcieport 0000:0c:01.0: new GPF Port phase 1 timeout: 70000000 us
[    4.698546] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 3 us
[    4.700998] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:01.0: new GPF Port phase 2 timeout: 2000000 us
[    4.742957] cxl_pci:cxl_gpf_setup:859: cxl_pci 0000:10:00.0: Device GPF timeout: 3000000 us (power needed: 51mW)
[    4.743036] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:00.0: Port GPF phase 1 timeout: 70000000 us
[    4.743050] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:00.0: Port GPF phase 2 timeout: 2000000 us
[    4.743064] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:00.0: new GPF Port phase 2 timeout: 3000000 us
[    4.743124] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:01.0: Port GPF phase 1 timeout: 70000000 us
[    4.743135] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:01.0: Port GPF phase 2 timeout: 2000000 us
[    4.743146] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:01.0: new GPF Port phase 2 timeout: 3000000 us
[    4.743232] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:02.0: Port GPF phase 1 timeout: 70000000 us
[    4.743243] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:02.0: Port GPF phase 2 timeout: 2000000 us
[    4.743254] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:02.0: new GPF Port phase 2 timeout: 3000000 us
[    4.743305] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:03.0: Port GPF phase 1 timeout: 70000000 us
[    4.743319] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:03.0: Port GPF phase 2 timeout: 2000000 us
[    4.743329] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:03.0: new GPF Port phase 2 timeout: 3000000 us
[    4.743443] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 70000000 us
[    4.743453] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 2000000 us
[    4.743465] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:00.0: new GPF Port phase 2 timeout: 3000000 us
[    4.743538] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 70000000 us
[    4.743548] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 2000000 us
[    4.743559] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:01.0: new GPF Port phase 2 timeout: 3000000 us
[    5.193687] cxl_pci:cxl_gpf_setup:859: cxl_pci 0000:11:00.0: Device GPF timeout: 4000000 us (power needed: 51mW)
[    5.194285] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:00.0: Port GPF phase 1 timeout: 70000000 us
[    5.194802] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:00.0: Port GPF phase 2 timeout: 3000000 us
[    5.195326] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:00.0: new GPF Port phase 2 timeout: 4000000 us
[    5.195907] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:01.0: Port GPF phase 1 timeout: 70000000 us
[    5.196412] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:01.0: Port GPF phase 2 timeout: 3000000 us
[    5.196929] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:01.0: new GPF Port phase 2 timeout: 4000000 us
[    5.197493] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:02.0: Port GPF phase 1 timeout: 70000000 us
[    5.198101] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:02.0: Port GPF phase 2 timeout: 3000000 us
[    5.198562] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:02.0: new GPF Port phase 2 timeout: 4000000 us
[    5.199079] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:03.0: Port GPF phase 1 timeout: 70000000 us
[    5.199539] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:03.0: Port GPF phase 2 timeout: 3000000 us
[    5.200003] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:03.0: new GPF Port phase 2 timeout: 4000000 us
[    5.200547] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 70000000 us
[    5.200997] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 3000000 us
[    5.201429] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:00.0: new GPF Port phase 2 timeout: 4000000 us
[    5.201917] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 70000000 us
[    5.202351] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 3000000 us
[    5.202781] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:01.0: new GPF Port phase 2 timeout: 4000000 us
[    5.222313] cxl_pci:cxl_gpf_setup:859: cxl_pci 0000:12:00.0: Device GPF timeout: 1000000 us (power needed: 51mW)
[    5.222795] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:00.0: Port GPF phase 1 timeout: 70000000 us
[    5.223233] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:00.0: Port GPF phase 2 timeout: 4000000 us
[    5.223705] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:01.0: Port GPF phase 1 timeout: 70000000 us
[    5.224149] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:01.0: Port GPF phase 2 timeout: 4000000 us
[    5.224607] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:02.0: Port GPF phase 1 timeout: 70000000 us
[    5.225038] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:02.0: Port GPF phase 2 timeout: 4000000 us
[    5.225498] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:03.0: Port GPF phase 1 timeout: 70000000 us
[    5.225933] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:03.0: Port GPF phase 2 timeout: 4000000 us
[    5.226430] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 70000000 us
[    5.226853] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 4000000 us
[    5.227310] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 70000000 us
[    5.227732] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 4000000 us

(iv) Hot removal - from (iii) above:
root@cxl:~# echo 1 > /sys/bus/pci/devices/0000\:11\:00.0/remove
[   83.208979] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:00.0: Port GPF phase 1 timeout: 70000000 us
[   83.209479] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:00.0: Port GPF phase 2 timeout: 4000000 us
[   83.209988] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:00.0: new GPF Port phase 2 timeout: 3000000 us
[   83.210498] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:01.0: Port GPF phase 1 timeout: 70000000 us
[   83.210965] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:01.0: Port GPF phase 2 timeout: 4000000 us
[   83.211417] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:01.0: new GPF Port phase 2 timeout: 3000000 us
[   83.211932] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:02.0: Port GPF phase 1 timeout: 70000000 us
[   83.212404] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:02.0: Port GPF phase 2 timeout: 4000000 us
[   83.212932] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:02.0: new GPF Port phase 2 timeout: 3000000 us
[   83.213622] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0e:03.0: Port GPF phase 1 timeout: 70000000 us
[   83.214200] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0e:03.0: Port GPF phase 2 timeout: 4000000 us
[   83.214647] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0e:03.0: new GPF Port phase 2 timeout: 3000000 us
[   83.215196] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 70000000 us
[   83.215650] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 4000000 us
[   83.216107] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:00.0: new GPF Port phase 2 timeout: 3000000 us
[   83.216601] cxl_core:cxl_pci_update_gpf_port:1100: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 70000000 us
[   83.217061] cxl_core:cxl_pci_update_gpf_port:1139: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 4000000 us
[   83.217507] cxl_core:cxl_pci_update_gpf_port:1154: pcieport 0000:0c:01.0: new GPF Port phase 2 timeout: 3000000 us

[*]: qemu diff:

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ec12c58d9f93..952c5c3d3171 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -439,6 +439,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
	      range1_base_hi = 0, range1_base_lo = 0,
	      range2_size_hi = 0, range2_size_lo = 0,
	      range2_base_hi = 0, range2_base_lo = 0;
+    GRand *rand = g_rand_new();

     /*
      * Volatile memory is mapped as (0x0)
@@ -500,7 +501,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
				REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
				REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
     dvsec = (uint8_t *)&(CXLDVSECDeviceGPF){
-        .phase2_duration = 0x603, /* 3 seconds */
+        .phase2_duration = g_rand_int_range(rand, 0x601, 0x606), /* 1-6 seconds */
	 .phase2_power = 0x33, /* 0x33 miliwatts */
     };
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
@@ -517,6 +518,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
				PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
				PCIE_FLEXBUS_PORT_DVSEC,
				PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
+    g_rand_free(rand);
 }

 static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 17c32b5736ab..3353b87b72a6 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -140,7 +140,7 @@ static void build_dvsecs(CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortGPF){
	 .rsvd        = 0,
	 .phase1_ctrl = 1, /* 1μs timeout */
-        .phase2_ctrl = 1, /* 1μs timeout */
+        .phase2_ctrl = 2, /* 2μs timeout */
     };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
				GPF_PORT_DVSEC_LENGTH, GPF_PORT_DVSEC,
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index d400f2aa1fc7..1226fcabfc50 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -121,8 +121,8 @@ static void build_dvsecs(CXLComponentState *cxl)

     dvsec = (uint8_t *)&(CXLDVSECPortGPF){
	 .rsvd        = 0,
-        .phase1_ctrl = 1, /* 1μs timeout */
-        .phase2_ctrl = 1, /* 1μs timeout */
+        .phase1_ctrl = 2, /* 2μs timeout */
+        .phase2_ctrl = 3, /* 3μs timeout */
     };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
				GPF_PORT_DVSEC_LENGTH, GPF_PORT_DVSEC,

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/driver-api/cxl/maturity-map.rst |   2 +-
 drivers/cxl/core/pci.c                        | 104 ++++++++++++++++++
 drivers/cxl/core/port.c                       |  56 ++++++++++
 drivers/cxl/cxl.h                             |   3 +
 drivers/cxl/cxlmem.h                          |   5 +
 drivers/cxl/cxlpci.h                          |  62 +++++++++++
 drivers/cxl/pci.c                             |  81 ++++++++++++++
 7 files changed, 312 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index df8e2ac2a320..99dd2c841e69 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -130,7 +130,7 @@ Mailbox commands
 * [0] Switch CCI
 * [3] Timestamp
 * [1] PMEM labels
-* [0] PMEM GPF / Dirty Shutdown
+* [1] PMEM GPF / Dirty Shutdown
 * [0] Scan Media
 
 PMU
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b46bc46aaa9..7e803c2ab5fe 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1054,3 +1054,107 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 
 	return 0;
 }
+
+int cxl_pci_update_gpf_port(struct pci_dev *pdev,
+			    struct cxl_memdev *cxlmd, bool remove)
+{
+	u16 ctrl;
+	int port_t1_base, port_t1_scale;
+	int port_t2_base, port_t2_scale;
+	unsigned long device_tmo, port_tmo;
+	int rc, dvsec;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	dvsec = pci_find_dvsec_capability(
+		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PORT_GPF);
+	if (!dvsec) {
+		dev_warn(&pdev->dev,
+			 "GPF Port DVSEC not present\n");
+		return -EINVAL;
+	}
+
+	/* check for t1 */
+	rc = pci_read_config_word(
+		pdev,
+		dvsec + CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET,
+		&ctrl);
+	if (rc)
+		return rc;
+
+	port_t1_base = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK,
+				 ctrl);
+	port_t1_scale = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK,
+				  ctrl);
+	if (port_t1_scale > GPF_TIMEOUT_SCALE_MAX) {
+		dev_warn(&pdev->dev, "GPF: invalid port phase 1 timeout\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Set max timeout such that vendors will optimize GPF flow to
+	 * avoid the implied worst-case scenario delays.
+	 */
+	device_tmo = gpf_timeout_us(7, GPF_TIMEOUT_SCALE_MAX);
+	port_tmo = gpf_timeout_us(port_t1_base, port_t1_scale);
+
+	dev_dbg(&pdev->dev, "Port GPF phase 1 timeout: %lu us\n", port_tmo);
+
+	if ((remove && device_tmo != port_tmo) || device_tmo > port_tmo) {
+		/* update the timeout in DVSEC */
+		ctrl = FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK,
+				   7);
+		ctrl |= FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK,
+				   GPF_TIMEOUT_SCALE_MAX);
+		rc = pci_write_config_word(
+			pdev,
+			dvsec + CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET,
+			ctrl);
+		if (rc)
+			return rc;
+
+		dev_dbg(&pdev->dev,
+			"new GPF Port phase 1 timeout: %lu us\n", device_tmo);
+	}
+
+	/* check for t2 */
+	rc = pci_read_config_word(
+		pdev,
+		dvsec + CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET,
+		&ctrl);
+	if (rc)
+		return rc;
+
+	port_t2_base = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK,
+			    ctrl);
+	port_t2_scale = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK,
+			     ctrl);
+	if (port_t2_scale > GPF_TIMEOUT_SCALE_MAX) {
+		dev_warn(&pdev->dev, "GPF: invalid port phase 2 timeout\n");
+		return -EINVAL;
+	}
+
+	device_tmo = gpf_timeout_us(mds->gpf_t2_base, mds->gpf_t2_scale);
+	port_tmo = gpf_timeout_us(port_t2_base, port_t2_scale);
+
+	dev_dbg(&pdev->dev, "Port GPF phase 2 timeout: %lu us\n", port_tmo);
+
+	if ((remove && device_tmo != port_tmo) || device_tmo > port_tmo) {
+		/* update the timeout in DVSEC */
+		ctrl = FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK,
+				   mds->gpf_t2_base);
+		ctrl |= FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK,
+				   mds->gpf_t2_scale);
+		rc = pci_write_config_word(
+			pdev,
+			dvsec + CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET,
+			ctrl);
+		if (rc)
+			return rc;
+
+		dev_dbg(&pdev->dev,
+			"new GPF Port phase 2 timeout: %lu us\n", device_tmo);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_update_gpf_port, CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index af92c67bc954..eacf813d4bb4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1393,6 +1393,61 @@ static struct device *endpoint_host(struct cxl_port *endpoint)
 	return &port->dev;
 }
 
+static void delete_update_gpf(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *port = cxlmd->endpoint;
+	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	struct cxl_memdev *max_cxlmd = NULL;
+	struct cxl_memdev_state *mds;
+	struct cxl_ep *ep;
+	unsigned long index;
+
+	/* first calculate the new max T2 timeout */
+	xa_for_each(&parent_port->endpoints, index, ep) {
+		struct cxl_memdev *this_cxlmd;
+		struct cxl_memdev_state *max_mds;
+
+		this_cxlmd = to_cxl_memdev(ep->ep);
+		if (cxlmd == this_cxlmd) /* ignore self */
+			continue;
+
+		if (!max_cxlmd) {
+			max_cxlmd = this_cxlmd;
+			continue;
+		}
+
+		mds = to_cxl_memdev_state(this_cxlmd->cxlds);
+		max_mds = to_cxl_memdev_state(max_cxlmd->cxlds);
+
+		if (gpf_timeout_us(mds->gpf_t2_base, mds->gpf_t2_scale) >
+		    gpf_timeout_us(max_mds->gpf_t2_base, max_mds->gpf_t2_scale))
+			max_cxlmd = this_cxlmd;
+	}
+
+	if (!max_cxlmd) /* no other devices */
+		return;
+
+	while (1) {
+		struct cxl_dport *dport;
+
+		parent_port = to_cxl_port(port->dev.parent);
+		mds = to_cxl_memdev_state(max_cxlmd->cxlds);
+
+		xa_for_each(&parent_port->dports, index, dport) {
+			if (!dev_is_pci(dport->dport_dev))
+				continue;
+
+			cxl_pci_update_gpf_port(to_pci_dev(dport->dport_dev),
+						max_cxlmd, true);
+		}
+
+		if (is_cxl_root(parent_port))
+			break;
+
+		port = parent_port;
+	}
+}
+
 static void delete_endpoint(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
@@ -1400,6 +1455,7 @@ static void delete_endpoint(void *data)
 	struct device *host = endpoint_host(endpoint);
 
 	scoped_guard(device, host) {
+		delete_update_gpf(cxlmd);
 		if (host->driver && !endpoint->dead) {
 			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
 			devm_release_action(host, cxl_unlink_uport, endpoint);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5406e3ab3d4a..00f6bb445fa1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -902,6 +902,9 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_pci_update_gpf_port(struct pci_dev *pdev,
+			    struct cxl_memdev *mds, bool remove);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..8f19d9615330 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -503,6 +503,11 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
+
+	/* cache Device GPF info */
+	u16 gpf_t2_base;
+	u16 gpf_t2_scale;
+	u32 gpf_power_mwatts;
 };
 
 static inline struct cxl_memdev_state *
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4da07727ab9c..5eae39641f96 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -40,9 +40,20 @@
 
 /* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
 #define CXL_DVSEC_PORT_GPF					4
+#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
+#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
+#define	    CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
+#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
+#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
+#define	    CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
 
 /* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
 #define CXL_DVSEC_DEVICE_GPF					5
+#define   CXL_DVSEC_DEVICE_GPF_PHASE_2_DURATION_OFFSET		0xA
+#define     CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_BASE_MASK		GENMASK(3, 0)
+#define	    CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_SCALE_MASK	GENMASK(11, 8)
+#define   CXL_DVSEC_DEVICE_GPF_PHASE_2_POWER_OFFSET		0xC
+#define	    CXL_DVSEC_DEVICE_GPF_PHASE_2_ACTIVE_POWER_MASK	GENMASK(31, 0)
 
 /* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
 #define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
@@ -129,4 +140,55 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+
+#define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
+
+/*
+ * The spec is over involved. Do not account for any ad-hoc host delays.
+ * Ie: propagation delay, host-side processing delays, and any other
+ * host/system-specific delays.
+ */
+static inline unsigned long gpf_other_delays_us(void)
+{
+	return 0;
+}
+
+static inline unsigned long gpf_timeout_us(int base, int scale)
+{
+	unsigned long tmo;
+
+	switch (scale) {
+	case 0: /* 1 us */
+		tmo = 1;
+		break;
+	case 1: /* 10 us */
+		tmo = 10UL;
+		break;
+	case 2: /* 100 us */
+		tmo = 100UL;
+		break;
+	case 3: /* 1 ms */
+		tmo = 1000UL;
+		break;
+	case 4: /* 10 ms */
+		tmo = 10000UL;
+		break;
+	case 5: /* 100 ms */
+		tmo = 100000UL;
+		break;
+	case 6: /* 1 s */
+		tmo = 1000000UL;
+		break;
+	case GPF_TIMEOUT_SCALE_MAX:
+		tmo = 10000000UL;
+		break;
+	default:
+		tmo = 0;
+		break;
+	}
+
+	tmo *= base;
+	return tmo + gpf_other_delays_us();
+}
+
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d..0f2150c392cb 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -807,6 +807,85 @@ static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
+static int cxl_gpf_setup(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct cxl_port *port;
+	int rc, gpf_dvsec;
+	u16 duration;
+	u32 power;
+	int device_t2_base, device_t2_scale;
+
+	/* get the timeouts for phase 2, given by the hardware */
+	gpf_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					      CXL_DVSEC_DEVICE_GPF);
+	if (!gpf_dvsec) {
+		dev_warn(&pdev->dev,
+			 "GPF Device DVSEC not present\n");
+		return -EINVAL;
+	}
+
+	rc = pci_read_config_word(
+		pdev,
+		gpf_dvsec + CXL_DVSEC_DEVICE_GPF_PHASE_2_DURATION_OFFSET,
+		&duration);
+	if (rc)
+		return rc;
+
+	device_t2_base = FIELD_GET(CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_BASE_MASK,
+			    duration);
+	device_t2_scale = FIELD_GET(CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_SCALE_MASK,
+			     duration);
+	if (device_t2_scale > GPF_TIMEOUT_SCALE_MAX) {
+		dev_warn(&pdev->dev, "GPF: invalid device timeout\n");
+		return -EINVAL;
+	}
+
+	/* cache device GPF timeout and power consumption for phase 2 */
+	mds->gpf_t2_base = device_t2_base;
+	mds->gpf_t2_scale = device_t2_scale;
+
+	rc = pci_read_config_dword(
+		pdev,
+		gpf_dvsec + CXL_DVSEC_DEVICE_GPF_PHASE_2_POWER_OFFSET,
+		&power);
+	if (rc)
+		return rc;
+
+	mds->gpf_power_mwatts = power;
+
+	dev_dbg(&pdev->dev, "Device GPF timeout: %lu us (power needed: %dmW)\n",
+	       gpf_timeout_us(device_t2_base, device_t2_scale),
+	       mds->gpf_power_mwatts);
+
+	/* iterate up the hierarchy updating max port timeouts where necessary */
+	port = cxlmd->endpoint;
+	while (1) {
+		struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+		struct cxl_dport *dport;
+		unsigned long index;
+
+		device_lock(&parent_port->dev);
+		xa_for_each(&parent_port->dports, index, dport) {
+			if (!dev_is_pci(dport->dport_dev))
+				continue;
+
+			cxl_pci_update_gpf_port(to_pci_dev(dport->dport_dev),
+						cxlmd, false);
+		}
+		device_unlock(&parent_port->dev);
+
+		if (is_cxl_root(parent_port))
+			break;
+
+		port = parent_port;
+	}
+
+	return rc;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -946,6 +1025,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
 
+	cxl_gpf_setup(pdev);
+
 	pci_save_state(pdev);
 
 	return rc;
-- 
2.39.5

