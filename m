Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92602482D3
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710450927; cv=none; b=o2kWh9nDu+0fr60gE0XJeudUejarX2fOAw2re98ScyeBkl7TQ2qXs8oaKtC9003wf2fbIetu5GO8gRIXiqLf4drLk2AxuD4kZBuBpc+EXpkAfwaeIwAA36povc4xwa09ebvl5hrT0k/yQ/s7v7A2KfJ3+QzD34RmkaIesbGGIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710450927; c=relaxed/simple;
	bh=p9eFowuuzx4NiGuAwNS3plLNgeU3/rZjfRbYUV+1ry0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6wyDpN3RWrdW98el4AyEiKzgep2Xbwz+MyEaf60ddKdLw82plmbhJvX2osWNiBcr1QOy8/KXPc8KCVJoXUA6HEa9GLXAesSgz3CC04MJiwrYILxK56o6gL9ru2i0ATUuNh2h8mCJBrrBLfrdGUbm5Mk8BqGCdxoRkYlHX3zgGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7FAC433F1;
	Thu, 14 Mar 2024 21:15:26 +0000 (UTC)
Date: Thu, 14 Mar 2024 17:17:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/trace: Properly initialize cxl_poison region
 name
Message-ID: <20240314171737.2025ef60@gandalf.local.home>
In-Reply-To: <ZfNmfCmgCs4Nc+EH@aschofie-mobl2>
References: <20240314201217.2112644-1-alison.schofield@intel.com>
	<20240314164136.6d10aa28@gandalf.local.home>
	<ZfNmfCmgCs4Nc+EH@aschofie-mobl2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Mar 2024 14:05:00 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> > I'm still curious to why NULL didn't work. I guess it may never have as=
 I
> > noticed there's nothing else doing that. There are cases that a variable
> > returns NULL and the __string() handles it. But I guess the compiler ge=
ts
> > confused if the NULL is a possible return to the condition in __string(=
). =20
>=20
> Here's the full warning spew:
>=20
> In file included from ./include/trace/define_trace.h:102,
>                  from drivers/cxl/core/trace.h:713,
>                  from drivers/cxl/core/trace.c:8:
> drivers/cxl/core/./trace.h: In function =E2=80=98trace_event_get_offsets_=
cxl_poison=E2=80=99:
> ./include/trace/stages/stage5_get_offsets.h:50:21: warning: argument 1 nu=
ll where non-null expected [-Wnonnull]
>    50 |                     strlen((src) ? (const char *)(src) : "(null)"=
) + 1)
>       |                     ^~~~~~
> ./include/trace/trace_events.h:263:9: n

The full warning didn't add any new information. The above was all I
needed. But I'm curious if you applied this patch if the warning will go
away. (Note I didn't test nor compile this).

-- Steve

diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stag=
es/stage5_get_offsets.h
index e30a13be46ba..dfae18d8f4df 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -9,6 +9,13 @@
 #undef __entry
 #define __entry entry
=20
+static inline const char *__string_src(const char *str)
+{
+	if (!str)
+		return "(null)";
+	return str;
+}
+
 /*
  * Fields should never declare an array: i.e. __field(int, arr[5])
  * If they do, it will cause issues in parsing and possibly corrupt the
@@ -47,7 +54,7 @@
=20
 #undef __string
 #define __string(item, src) __dynamic_array(char, item,			\
-		    strlen((src) ? (const char *)(src) : "(null)") + 1)
+		    strlen(__string_src(src)) + 1)
=20
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
